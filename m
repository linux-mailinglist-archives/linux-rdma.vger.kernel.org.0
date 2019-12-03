Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAE010F44A
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2019 01:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbfLCA5C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Dec 2019 19:57:02 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:46152 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfLCA5C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Dec 2019 19:57:02 -0500
Received: by mail-pg1-f171.google.com with SMTP id z124so699535pgb.13
        for <linux-rdma@vger.kernel.org>; Mon, 02 Dec 2019 16:57:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wA1n/F7XrdUO02DC+GAIWyjmkhz2Qc0KPGNZuwg12WE=;
        b=BVLXlFxO4H6LjCYS1riMI7yNBipyUAFpz5vWJo5oLC5Ip8mjDtSPMe9jmoNZ6KoP/j
         B4QIiW1Ptsb/MU2303I5gHPhKpCOWJGRGyQltK+Pj5kIbIzsA6S7qHWYThqNePw4KNLv
         FJ+lTIp4HOX73UCD9FGlcz+Swn9waCoA+SxKbE8joPhymagLMFdwIufx3MDZoYRVUCIT
         rLf0IGIw2knVnffyCpWvBmsnM6BHunhfCtWGU17B7YHu4L9E57mtg3qAbI6PJiJ9MRzT
         F5jeuUd0XjF8CkhSQmzqKsiS1hpgUaZVpMWvUnj5DeZpf79oBJ71tfC77kb4pNG5jGTA
         MKSA==
X-Gm-Message-State: APjAAAUybFWNLO1m8DEAHdbIhD4E5hTQOyBD0zFdacT/2U6YqXnuzZIi
        yJEBD0aRPPP71IrMcAa98fYPSQDL
X-Google-Smtp-Source: APXvYqwBRfLk7cM7zJiTJBRoiOX5bjW5H487noj5jYIbJbDOQ+REazjNBBXkEpJTJNK1Sodv67O4gg==
X-Received: by 2002:a62:ee09:: with SMTP id e9mr1708629pfi.243.1575334621302;
        Mon, 02 Dec 2019 16:57:01 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id s3sm802389pgi.31.2019.12.02.16.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 16:57:00 -0800 (PST)
Subject: Re: [question]can hard roce and soft roce communicate with each
 other?
To:     Steve Wise <larrystevenwise@gmail.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     wangqi <3100102071@zju.edu.cn>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <53ed2e18-c58e-1e9c-55f8-60b14dfa2052@zju.edu.cn>
 <4433c97d-218a-294e-3c03-214e0ef1379f@acm.org>
 <20191127111008.GC10331@unreal>
 <CADmRdJfEr405W1+m=jYDYV=MZtk_0mEamUA7UXt6rKangnAC1g@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8e8d9ecc-9406-11b3-242b-3a84f3702f79@acm.org>
Date:   Mon, 2 Dec 2019 16:56:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CADmRdJfEr405W1+m=jYDYV=MZtk_0mEamUA7UXt6rKangnAC1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/27/19 6:24 AM, Steve Wise wrote:
> I've recently uncovered a bug in RXE that causes iCRC errors when
> running between RXE and a correct RoCE implementation.  The bug is
> that RXE is not including pad bytes in its iCRC calculations.  So if
> the application payload is not 4B aligned then you'll hit this bug.
> You can see this by running ib_write_bw, for example, between mlnx_ib
> and rxe.
> 
> works:  ib_write_bw -s 32 -n 5
> fails: ib_write_bw -s 33 -n 5
> 
> I'll post a patch this coming weekend hopefully.
  Hi Steve,

Will that patch support coexistence of softRoCE implementations that use 
different CRC calculation methods?

Thanks,

Bart.
