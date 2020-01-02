Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B836F12EBA5
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2020 23:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgABWGF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 17:06:05 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:41791 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgABWGE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 17:06:04 -0500
Received: by mail-pf1-f182.google.com with SMTP id w62so22652302pfw.8;
        Thu, 02 Jan 2020 14:06:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5wT99eSrUuYJUb5TASPNFPzfvrQJudr2tcXdWYyVAkQ=;
        b=fcB/A3B/ErvB37FGMiqbofuyYAxFJZYX5Sta9p3w+P3/sBBgG+EYy0760BQtn53FwA
         AMSTgVXWbFIF7/ylDNzrs5KiMJBPsR2t06OZ1LlLYa2MPTGybGiBUF8KQz+ylGb3z8nG
         BUxqmA7ofxpEP87NLcTD+1m2/Okmp8sItZUQhJEDpIvhN+0jINaNkq7pK4Frv4eb8SOe
         iQeIwddJbirmr9/GIrohe9TrtTb1L+vFglxwe3vGrbOKLNLTtbzSLesGI5qJIcv7lXPq
         MZbCbA7K7O2uMaNKnMk6O0TFc6cm82if6bwX8VYoLH1zEIDb51lk72x/JBc2TT+9lk0z
         JS2g==
X-Gm-Message-State: APjAAAU6wj9FRf0yXFe/DKADy0c8GCKWHp9CxqCS4KSFVMKsfM+miViY
        1JjAiz8oVyBznoPvWZPimDk=
X-Google-Smtp-Source: APXvYqzwMETyW96QYyM/QhmxYahrDgw/lmq9phf03t8Xx0PHcBlHLhj3wsUue60BqKuVnsAS1cwo/Q==
X-Received: by 2002:a65:52ca:: with SMTP id z10mr86183146pgp.47.1578002763994;
        Thu, 02 Jan 2020 14:06:03 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id g10sm59758469pgh.35.2020.01.02.14.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 14:06:03 -0800 (PST)
Subject: Re: [PATCH v6 12/25] rtrs: server: sysfs interface functions
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-13-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <6584a511-6d4d-e0e3-453a-c55256bf023b@acm.org>
Date:   Thu, 2 Jan 2020 14:06:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191230102942.18395-13-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/30/19 2:29 AM, Jack Wang wrote:
> +static struct kobj_attribute rtrs_srv_disconnect_attr =
> +	__ATTR(disconnect, 0644,
> +	       rtrs_srv_disconnect_show, rtrs_srv_disconnect_store);

Could __ATTR_RW() have been used here?

> +static struct kobj_attribute rtrs_srv_hca_port_attr =
> +	__ATTR(hca_port, 0444, rtrs_srv_hca_port_show, NULL);

Could __ATTR_RO() have been used here?

Thanks,

Bart.
