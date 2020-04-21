Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D771B2BAA
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2020 17:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgDUPxW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Apr 2020 11:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725613AbgDUPxV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Apr 2020 11:53:21 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B514C061A10
        for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2020 08:53:21 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 145so4491385pfw.13
        for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2020 08:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mZBPY1fpy9btZ9cr9GZUKUH9M5h2ZIyQ7J4HV3xTWCw=;
        b=FW5h68Svi9Ufjpxyf3s3/7ona7add8+nQd0A3NBa97f4w8EnOEnfVPOdVbD5KDQ8Vk
         hwONtmV5SURT1kW23Nl8io0wpFT3d7XubNF9FPyLa+X2eICDG6hjvsckZlR4O/IRmHdF
         Wfu0MAg1g1OMrc+NQmT8EYJNy1aiXd3ghNGPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mZBPY1fpy9btZ9cr9GZUKUH9M5h2ZIyQ7J4HV3xTWCw=;
        b=dPSvZ7p3h0W/5ijhszmUJHoS6toxxTxGOL6ldkEV3/pGxhDe01UrpY1QjovZTarJE/
         7IMYUnbbo8dRjJa4QvELKtMCp7TaR6aXnCczzRUdEWC87m5Fo6ftCaGE9vOJWBxS58HZ
         tDmOsXcd2cHDwyzRxeqFoffB4KQdRa3DEqXXm1YFfIPNmrX3Ob2O1R0CbL2dS/EPFk2U
         2bcHMgCJbUJHFhS02TO5KtLa698j0xwfrWk5kKIiw3gsi7u4kr7my3XszKweM8edv0KB
         p3Ku2b3q31bxMnHwPjTtCG6cFl+76MyElW+oaZ8KpbUJN+mQO9nz+zEaFVXVnHc9yw/y
         /kGA==
X-Gm-Message-State: AGi0Pub3kX9Ozp5CznLuHgCCkFwivaHmig/HkKzY99dsK9K2BfV5orDq
        D6a+d7Ed0WMdcALw7JYd7kQ67A==
X-Google-Smtp-Source: APiQypLWDAdreOGwS/27Ss480aYwHAHQjOkV4IZCra7nzmwsx4VJBYQT2i9Rd5F5OBuOY5GVKL77fA==
X-Received: by 2002:a63:f843:: with SMTP id v3mr22778575pgj.421.1587484401053;
        Tue, 21 Apr 2020 08:53:21 -0700 (PDT)
Received: from [10.230.185.141] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id i18sm2784894pjx.33.2020.04.21.08.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 08:53:20 -0700 (PDT)
Subject: Re: [PATCH 01/17] nvme: introduce namespace features flag
To:     Christoph Hellwig <hch@lst.de>, Max Gurtovoy <maxg@mellanox.com>
Cc:     axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
        martin.petersen@oracle.com, shlomin@mellanox.com,
        linux-rdma@vger.kernel.org, israelr@mellanox.com,
        vladimirk@mellanox.com, linux-nvme@lists.infradead.org,
        idanb@mellanox.com, jgg@mellanox.com, oren@mellanox.com,
        kbusch@kernel.org
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-3-maxg@mellanox.com> <20200421115912.GB26432@lst.de>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <1ffeee50-9c96-495f-b82b-bf3873e95183@broadcom.com>
Date:   Tue, 21 Apr 2020 08:53:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421115912.GB26432@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/21/2020 4:59 AM, Christoph Hellwig wrote:
> On Fri, Mar 27, 2020 at 08:15:29PM +0300, Max Gurtovoy wrote:
>> From: Israel Rukshin <israelr@mellanox.com>
>>
>> Centralize all the metadata checks to one place and make the code more
>> readable. Introduce a new enum nvme_ns_features for that matter.
>> The features flag description:
>>   - NVME_NS_EXT_LBAS - NVMe namespace supports extended LBA format.
>>   - NVME_NS_MD_HOST_SUPPORTED - NVMe namespace supports getting metadata
>>     from host's block layer.
>>   - NVME_NS_MD_CTRL_SUPPORTED - NVMe namespace supports metadata actions
>>     by the controller (generate/strip).
> So whole I like the ->features flag, the defintion of these two
> metadata related features really confuses me.
>
> Here are my vague ideas to improve the situation:
>

Care to look at any of the RFC items I posted on 2/24 - which does 
things a little differently ?   Perhaps find a common ground with Max's 
patches.
http://lists.infradead.org/pipermail/linux-nvme/2020-February/029066.html

Granted I've tweaked what I sent a little as there was no need to make 
nvme_ns_has_pi accessible to the transport.

-- james

