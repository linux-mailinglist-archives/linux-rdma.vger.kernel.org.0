Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE0B7A8998
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 18:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbjITQgi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 12:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbjITQgh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 12:36:37 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FEBDD;
        Wed, 20 Sep 2023 09:36:31 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1bf6ea270b2so54271885ad.0;
        Wed, 20 Sep 2023 09:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695227791; x=1695832591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0e1vGnR7MOfjg1C83c5zP7mELiJp8sjdSUZ0Nn1mgM=;
        b=jhiZshkSVpn0tQfWvWyb7QGCznzHYq74B57e3m0anPkHj583jQLYuElPxbX0VYCCav
         q+FfoHAIT3hMogM4OMEvtZQ7eQqA0qzKJtOQGMACzCF5eBES92PlxfNe8fLuB3NaaEkx
         M37KCWdpTmFD+XuHHJDV29xC3lwnFp4biGmuFTsvhDIqWrv5NJ3owMHhhs4myz4fpjD1
         xWqL4MkA5lYGasxHVMa4GL+fmB1tOxG6lLuFvtXM/ITq1t0KszibvuJLEqA0EdOQt8ib
         1FCz9P55iUmGyN6CTmJqMD0HFMb+V3oM+5t9cbR4PiAHsg/J0D9+KCuFWp7F03TNM3bx
         oT1A==
X-Gm-Message-State: AOJu0Yz5oH5t4WSsh3pQvn25qm4BZQGYzEuNVhYwB8MNeR2fU0UUv810
        BHtcThQ5Mc5/effBDkJYeVmVOA6pGWE=
X-Google-Smtp-Source: AGHT+IEaJD3FL2L7U/68lukE3lCi0BubucZkw+pqMoNICp9zAgci8lsy/QIVOuglR08oPYR1pmSRvQ==
X-Received: by 2002:a17:902:d2c2:b0:1b8:c6:ec8f with SMTP id n2-20020a170902d2c200b001b800c6ec8fmr3839103plc.46.1695227790829;
        Wed, 20 Sep 2023 09:36:30 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:b0c6:e5b6:49ef:e0bd? ([2620:15c:211:201:b0c6:e5b6:49ef:e0bd])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902b28a00b001bc45408d26sm1189477plr.36.2023.09.20.09.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 09:36:29 -0700 (PDT)
Message-ID: <6fc3b524-af7d-43ce-aa05-5c44ec850b9b@acm.org>
Date:   Wed, 20 Sep 2023 09:36:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
 <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
 <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
 <plrbpd5gg32uaferhjj6ibkt4wqybu3v3y32f4rlhvsruc7cu4@2pgrj2542da2>
 <18a3ae8c-145b-4c7f-a8f5-67840feeb98c@acm.org>
 <ab93655f-c187-fdab-6c67-3bfb2d9aa516@gmail.com>
 <9dd0aa0a-d696-a95b-095b-f54d6d31a6ab@linux.dev>
 <d3205633-0cd2-f87e-1c40-21b8172b6da3@linux.dev>
 <nqdsj764d7e56kxevcwnq6qoi6ptuu3bi6ntfakb55vm3toda7@eo3ffzzqrot7>
 <5a4efe6f-d8c6-84ce-377e-eb64bcad706c@linux.dev>
 <f50beb15-2cab-dfb9-3b58-ea66e7f114a6@gmail.com>
 <fe61fdc5-ca8f-2efc-975d-46b99d66c6f5@linux.dev>
 <afc98035-1bb8-f75c-451a-8e3e39fb74aa@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <afc98035-1bb8-f75c-451a-8e3e39fb74aa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/20/23 09:24, Bob Pearson wrote:
> The verbs APIs do not make real time commitments. If a ULP fails 
> because of response times it is the problem in the ULP not in the 
> verbs provider.

I think there is evidence that the root cause is in the RXE driver. I
haven't seen any evidence that there would be any issues in any of the
involved ULP drivers. Am I perhaps missing something?

Bart.
