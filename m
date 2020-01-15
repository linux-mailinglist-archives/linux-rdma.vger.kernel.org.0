Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4614513C8D2
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 17:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgAOQI7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 11:08:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41562 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgAOQI7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jan 2020 11:08:59 -0500
Received: by mail-pg1-f193.google.com with SMTP id x8so8410239pgk.8
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jan 2020 08:08:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wzCF+0GUKdHk/4ZwKiPl9Ay8suk8U2wlOg0hb0fSQkg=;
        b=f1JxbYZVMgRMT4myB/hmhrErbf3QF5z6g9hYRFu9PyF3+Bmi1vAlEwQ7o7dCWBem9y
         OV0Z4bc4TS4o/6quZDjEUb3VJ/MioRPs/REkysQm9FVFIPPZg4BAMlP85iH+jrdxt18D
         O9rfFspkd6eJZPthHNAsarWv6Vnv35YmpX+eKPjuxsU64uTURtLzxqx3As78Pa62Pvgm
         lYziWSPYNMxcdpLTrtV4vJKEoX/khjblnXC0oPt1FlUf0Ft47hpgt91UlDdwMPUwr2oD
         ndW2BlCu7C74H/LdBrAc2C16XoGcW3E64n/QJU2pGpfH5eubp7rrOp0M9NcOvPaZst3d
         ssXg==
X-Gm-Message-State: APjAAAXFsWIe9NhjcBsW7kAgmm1U5YSZSlIGCi2+pHARmZRxEX+c9Fwb
        g01abA1AnZkjEV4wvtNEJqCIwFnR
X-Google-Smtp-Source: APXvYqyDpp6UdSBrnm3+5FWFuupsYG8CCqYjm6/4tbzJ4QD2qNm6Uly+amhDQZ8RIKY2dEhOBfv9CA==
X-Received: by 2002:aa7:83d6:: with SMTP id j22mr32504660pfn.122.1579104538526;
        Wed, 15 Jan 2020 08:08:58 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id t187sm22731158pfd.21.2020.01.15.08.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 08:08:57 -0800 (PST)
Subject: Re: [PATCH] IB/srp: Never use immediate data if it is disabled by a
 user
To:     Sergey Gorenko <sergeygo@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
References: <20200115133055.30232-1-sergeygo@mellanox.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <43ac392c-3877-f0a6-015d-c35e8a44f2e7@acm.org>
Date:   Wed, 15 Jan 2020 08:08:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115133055.30232-1-sergeygo@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/15/20 5:30 AM, Sergey Gorenko wrote:
> Some SRP targets that do not support specification SRP-2, put
> the garbage to the reserved bits of the SRP login response.
> The problem was not detected for a long time because the SRP
> initiator ignored those bits. But now one of them is used as
> SRP_LOGIN_RSP_IMMED_SUPP. And it causes a critical error on
> the target when the initiator sends immediate data.
> 
> The ib_srp module has a use_imm_date parameter to enable or
> disable immediate data manually. But it does not help in the above
> case, because use_imm_date is ignored at handling the SRP login
> response. The problem is definitely caused by a bug on the target
> side, but the initiator's behavior also does not look correct.
> The initiator should not use immediate data if use_imm_date is
> disabled by a user.
> 
> This commit adds an additional checking of use_imm_date at
> the handling of SRP login response to avoid unexpected use of
> immediate data.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
