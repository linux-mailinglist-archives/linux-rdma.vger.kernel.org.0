Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB0418C737
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 06:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgCTFrp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 01:47:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36528 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgCTFrp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Mar 2020 01:47:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id g62so5010879wme.1
        for <linux-rdma@vger.kernel.org>; Thu, 19 Mar 2020 22:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7dPg4U8svUYFJEtkVAOtkWkAFExO6Ih2I/Gf71e770k=;
        b=JAyuPSDgyT8742R91jQFAcO0933XfGrvG9uem+VwFkUaMLobiUhfDwT1nNg6F6XcIn
         zHUuCqyNCABgCAAyDqCTqBY+MEdyYx5vRtQ1MZV7gRQUCSm343xryGUbdWtl9xUuENq0
         xIbpUMvbXpmWf08nNXd5x9qIP42voMwY3ba7jrbKNTZKPByzcCn+Ov56afqvhBAMaSHg
         BEFObyS5R7J5aTtRmTLBgoe6zJgZtRbvkWDVFITrIK2h+Vimdj5BpmvaFkgbIDoME/J/
         PAC5ik1tM/PJCehNG8Hb7FfVT9cBtuH9dxzSG7ngQptl8U7amILOE02T7YnG7+J+WTc8
         K2iA==
X-Gm-Message-State: ANhLgQ3ieiyjBqHfj0avLt3zknYOfCuMN+28hxcci2JaiO4w1YebM/bq
        sW2cWOohvW6fb1XMmnyjzqo=
X-Google-Smtp-Source: ADFU+vsrmyMUlvge3f/3ZNNku10L39XdAJssNSx+eOYzS9WDLnh76Yx/+DBPmgUcq1KpYN5CavWpkw==
X-Received: by 2002:a7b:ca4e:: with SMTP id m14mr5238981wml.164.1584683263276;
        Thu, 19 Mar 2020 22:47:43 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:f092:4ccc:3e48:6081? ([2601:647:4802:9070:f092:4ccc:3e48:6081])
        by smtp.gmail.com with ESMTPSA id p15sm6574338wro.68.2020.03.19.22.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 22:47:42 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] nvmet-rdma: use SRQ per completion vector
To:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        hch@lst.de, loberman@redhat.com, bvanassche@acm.org,
        linux-rdma@vger.kernel.org
Cc:     rgirase@redhat.com, vladimirk@mellanox.com, shlomin@mellanox.com,
        leonro@mellanox.com, dledford@redhat.com, jgg@mellanox.com,
        oren@mellanox.com, kbusch@kernel.org, idanb@mellanox.com
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-4-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <cf52b987-e1d4-0b82-03a2-698ca79bfce0@grimberg.me>
Date:   Thu, 19 Mar 2020 22:47:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200318150257.198402-4-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> +static void nvmet_rdma_destroy_srqs(struct nvmet_rdma_device *ndev)
>   {
> -	if (!ndev->srq)
> +	int i;
> +
> +	if (!ndev->srqs)
>   		return;
>   
> -	nvmet_rdma_free_cmds(ndev, ndev->srq_cmds, ndev->srq_size, false);
> -	ib_destroy_srq(ndev->srq);
> +	for (i = 0; i < ndev->srq_count; i++)
> +		nvmet_rdma_destroy_srq(ndev->srqs[i]);
> +
> +	rdma_srq_pool_destroy(ndev->pd);
> +	kfree(ndev->srqs);
> +	ndev->srqs = NULL;
> +	ndev->srq_count = 0;
> +	ndev->srq_size = 0;

What is the point assigning these?
