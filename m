Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9945D404415
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Sep 2021 05:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbhIIDyD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 23:54:03 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:36720 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhIIDyD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Sep 2021 23:54:03 -0400
Received: by mail-pl1-f175.google.com with SMTP id w6so212955pll.3
        for <linux-rdma@vger.kernel.org>; Wed, 08 Sep 2021 20:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ej2KiOGrICD2K69vERWbpdoAh4tvfug+oniqAX5CvSM=;
        b=QMz8io9UnX6POqmQ+H6Gv8yiUzoV7NEi8nZPfzGOgeA10dq1YxTkx/PvBq+jmNlat/
         N88lQwtxz+/gfjuSIk3VOKPgiWnN3v7kydtekFrz0NRwGEaIJk/5Tc+MqIKEwKv56CQQ
         sCn5ZNJfgM7OYfR1CgYt07FgD8dg+QChYzDAbneiFh0nUW+QwrHsZKBcHa3UjieadXqk
         7cgBoX/p8y8tWclAeHbdK0S6VZMaB4N+089p7RpESoSQR6qYC1C/Q43ajs8wUG53qyN5
         gKxutpS3COvOYx5TeDG7tDanJRn/4ezVDh5Pvc8fJBYOx4VhuNUxIHxBCgbkwa5Coc5b
         1a9Q==
X-Gm-Message-State: AOAM531GXgMLEv/Zbi6btqc0x2QzZTVbgK6annrwfrJzTyquUR8rKMuQ
        KkbB7D4GJv5nU7gC09hXuoQ=
X-Google-Smtp-Source: ABdhPJzjO+sBuxK/I7ah62Abg4CAAMu03IVN35HPgCEaQj816W+oV7nT3nJvxUSXZmWVF5vTuhXBPQ==
X-Received: by 2002:a17:90a:130f:: with SMTP id h15mr1102250pja.183.1631159574465;
        Wed, 08 Sep 2021 20:52:54 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:1d79:8736:6331:7ea1? ([2601:647:4000:d7:1d79:8736:6331:7ea1])
        by smtp.gmail.com with UTF8SMTPSA id b27sm409266pge.52.2021.09.08.20.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 20:52:53 -0700 (PDT)
Message-ID: <c6e80fc3-6417-a770-d90a-46eb9955f82f@acm.org>
Date:   Wed, 8 Sep 2021 20:52:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH for-next 0/5] RDMA/rxe: Various bug fixes.
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20210908052928.17375-1-rpearsonhpe@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20210908052928.17375-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/7/21 22:29, Bob Pearson wrote:
> The first patch is a repeat of an earlier patch after rebasing to
> for-next version 5.14.0-rc6+.

Hi Bob,

What is for-next version 5.14.0-rc6+? I tried to apply this series on 
v5.14, v5.14-rc6 and Jason's for-rc branch but 'git am' refused to apply 
this series on all these kernel versions ...

Thanks,

Bart.
