Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1593905E8
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 17:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhEYPzf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 11:55:35 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:41868 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhEYPze (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 11:55:34 -0400
Received: by mail-pg1-f176.google.com with SMTP id r1so8224945pgk.8
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 08:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kXK9W9HcyTgA/eluBawX3v88OjEefKRNpXA4GeoWTZs=;
        b=cSYliEjY+1oIyLsTM7uE0h366h7LxmuFEY6kRxnMGcd5JDHpMj7MgsPccDqqkkOodt
         jX6djoa97aTAiWmXwhUfk+j5UFwUbbVdfk075oOOxpgNTkfC749LiYLtfkYDKMSAkBTM
         KdyuY1P+JNZDF0mPkE4eeZP094IAjvzRwdf5FpWojTTRv1LWErWnZWmdAZW8dW7cD4YT
         AoWi5gWdYtAW9UfQyTxnPs/DiKrjPGCy7nc7BnBDvilsdWl0bmp69NLEIC4uJ4muQBeg
         HmO5Pxbw83DN9LFScTRskGAO19X6lhGHyoEoCkL1XQwwhOevdky/o7o+BIRoPMRCUaFu
         /ULg==
X-Gm-Message-State: AOAM532XXPAadlLBWGLj/Eb26lc5P8PLiRHF04y71sqf2S1RHgFhx1+L
        CWbYYjGLfoFDyadnzusgpdk=
X-Google-Smtp-Source: ABdhPJwPdQ0lbX3onUDLmNxWBiIv/zzOt+HlXa2lom5FLZCQA1d03sXFcTjYNr1u7ysJVo4fBboToA==
X-Received: by 2002:a62:7652:0:b029:2d9:4602:7292 with SMTP id r79-20020a6276520000b02902d946027292mr31284148pfc.52.1621958043855;
        Tue, 25 May 2021 08:54:03 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4f6:7b8c:d4a2:7714? ([2601:647:4802:9070:4f6:7b8c:d4a2:7714])
        by smtp.gmail.com with ESMTPSA id g8sm13469727pfo.85.2021.05.25.08.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 08:54:03 -0700 (PDT)
Subject: Re: [PATCH 1/1] IB/isert: align target max I/O size to initiator size
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
Cc:     israelr@nvidia.com, alaa@nvidia.com
References: <20210524085215.29005-1-mgurtovoy@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <46c4d30d-510d-b329-4793-8a354642632e@grimberg.me>
Date:   Tue, 25 May 2021 08:54:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210524085215.29005-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Since the Linux iser initiator default max I/O size set to 512KB and
> since there is no handshake procedure for this size in iser protocol,
> set the default max IO size of the target to 512KB as well.
> 
> For changing the default values, there is a module parameter for both
> drivers.

Is this solving a bug?
