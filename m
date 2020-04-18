Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84C11AF5C6
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Apr 2020 01:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgDRXBr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 Apr 2020 19:01:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43518 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgDRXBr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 18 Apr 2020 19:01:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id u9so3034663pfm.10;
        Sat, 18 Apr 2020 16:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V4cZY/tZI/5BtLraJVLO57HFJT+0fqpSncYi3Zy+2Go=;
        b=KLexCcqp4p2ouxm5WmEQfQExNM/gOlt41rPpTAWrvxmgXRLnbqsnRn9EuWyhuoPq0R
         5nTGiVX5pjfuJUoVFsFlZHXk0okGYU6IGTqhggSOIqWAXRtShygsuJgehoRPR6TkSN5a
         67G53RGHasGcfem3W9OBG3ClUcnl30wtqtD4MVKpOk0zfvvi3IlQQS/MzgEINESq59br
         ppqRvWukULHWpqN+MNwABTxVKBlcC11Ni5mvnAyKI4T58Glxo61T9OF+uiZnX/LIeskn
         BdgaelOOXs+ilrXpaMEuk5HX7pRolV3SaylBDTnco7m//npNozwl4BWlNiirKLMbaGae
         9qLw==
X-Gm-Message-State: AGi0PuaEUvLYRMRyzuMwQrnJfS4skj/n9TlUmuYnZV/X0XFLps11yAjP
        oOzHoYa+l2Sf+25hkk4ONgw=
X-Google-Smtp-Source: APiQypJFM9PvUDclrd/a+vsZOP5zCCdVITBBK80YAunCcAe+ZR5UeC8OuKe5HhD6/D7/Bv2dSObMDw==
X-Received: by 2002:a63:fe54:: with SMTP id x20mr9274883pgj.195.1587250905458;
        Sat, 18 Apr 2020 16:01:45 -0700 (PDT)
Received: from [100.124.15.238] ([104.129.198.228])
        by smtp.gmail.com with ESMTPSA id i15sm11410820pfo.195.2020.04.18.16.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 16:01:44 -0700 (PDT)
Subject: Re: [PATCH v12 15/25] block/rnbd: private headers with rnbd protocol
 structs and helpers
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
 <20200415092045.4729-16-danil.kipnis@cloud.ionos.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d972a2e2-a26d-fa24-d5ba-6beac2ee2b69@acm.org>
Date:   Sat, 18 Apr 2020 16:01:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415092045.4729-16-danil.kipnis@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/15/20 2:20 AM, Danil Kipnis wrote:
> These are common private headers with rnbd protocol structures,
> logging, sysfs and other helper functions, which are used on
> both client and server sides.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
