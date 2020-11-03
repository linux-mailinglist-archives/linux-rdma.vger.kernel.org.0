Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2C32A50CA
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Nov 2020 21:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgKCUTH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Nov 2020 15:19:07 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:40026 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCUTH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Nov 2020 15:19:07 -0500
Received: by mail-wr1-f49.google.com with SMTP id 33so9019038wrl.7;
        Tue, 03 Nov 2020 12:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ilV3HNTdX+GLDstbn1VwLquy0/jbMbZvmjeVTmb6ha/WqYd8lVMA3KFXBPjgOyp4Bo
         +mkQWzYSXLNElGn5n8NV+a+GiGPZptv5UeWyenyRgBgSXIfUqD5ePebXQv1WI7gyONFe
         4P7y7cL189uI7k+90THtHBpMbl6VOwpQQN3jxLZJWbP0yaMI+kmGGkFsP/Lz5qBnCvdH
         sZ8VBK1EoyDtDKVlY66e5Y1zzWylb18Tx1etpJ48TpY9eHCzTRgcKK9rnJWaGxyBBf3j
         nNZQFLOIfgAZ8iFNh+tv5AWSDHuvPRHWNpvlJ1OyvleOwhDmrWG6iOOW0OEA/aYqUy9p
         zaNw==
X-Gm-Message-State: AOAM532DmqwDPXTnem3sbeFFgqU/+Mg/9WBNoKtxzDI+4u+Purr2QNi/
        BObir5IHVcNCtFRx6/Ho5yR1kfB+4/c=
X-Google-Smtp-Source: ABdhPJxXbSaOju7of9eJvVACmCUBk4tzsHvKH4iLsIN5EnDxZtct5Z+EjSLUYy1/VDlZgeW2fu5zxQ==
X-Received: by 2002:a5d:4083:: with SMTP id o3mr26287094wrp.44.1604434745546;
        Tue, 03 Nov 2020 12:19:05 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:a1e3:53cb:84b3:6393? ([2601:647:4802:9070:a1e3:53cb:84b3:6393])
        by smtp.gmail.com with ESMTPSA id y200sm4538638wmc.23.2020.11.03.12.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 12:19:05 -0800 (PST)
Subject: Re: [PATCH -next] IB/isert: Fix warning Comparison to bool
To:     Zou Wei <zou_wei@huawei.com>, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1604404674-32998-1-git-send-email-zou_wei@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bdb9f12a-cac4-fb88-882e-7e0c16a66c75@grimberg.me>
Date:   Tue, 3 Nov 2020 12:19:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1604404674-32998-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
