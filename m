Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C6A788900
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Aug 2023 15:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbjHYNuC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Aug 2023 09:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245266AbjHYNtn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Aug 2023 09:49:43 -0400
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C462134;
        Fri, 25 Aug 2023 06:49:41 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-56c250ff3d3so1458983a12.1;
        Fri, 25 Aug 2023 06:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692971381; x=1693576181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5BoRjLg4nGdp7vIzAcWK0iyi7HX6jnkYl9l+pRzvaes=;
        b=f/8iZJlHrXQRLzIYteN0YmapwsW+UZnwNLPFjm/jTZI3/cS1ZFNCWT1hal+Eh4PIA9
         olgCTcuCSnWGU9PZVyvlFT781RnN49QybIOKxKd7/2sdkPafMJDPqGCouEjRv8YnrPQR
         vSv/9inTx6UIJO3kyBgbDP2uhbyvZ1AmA9SMpOLpubZr8/+cY+aRFwsMYVutqIJiA3kq
         ofz3EvuRTzGTnPw3TwafNOL1iiU5fAHQbFRpitP67s6UxyVrOpasNM1CZ9c10tRw02Aq
         3FM745O2VVmkigZwSnQL505fgmg8gsHOnNPhJeNPMg2dyUQaBPl2BgzocobObaAKaHUN
         c/9w==
X-Gm-Message-State: AOJu0YxGoHt4GwuaPyNYlZoKXluOAos/u8CFQY53PwlCyZZDeb+8i1kx
        eD7Gtrra+TURldk3FYOJSWRgzPIbjgM=
X-Google-Smtp-Source: AGHT+IEXcaFT8ACCYHdh6CcpROSxHESrZGv+dn9c7yBuAgmfQNfw1EQavA+OCxHvRa2cdTTWsnVdrg==
X-Received: by 2002:a17:90a:7408:b0:26b:513a:30b0 with SMTP id a8-20020a17090a740800b0026b513a30b0mr28675817pjg.10.1692971380999;
        Fri, 25 Aug 2023 06:49:40 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id js23-20020a17090b149700b0026094c23d0asm1668170pjb.17.2023.08.25.06.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 06:49:40 -0700 (PDT)
Message-ID: <55f5361a-13d2-470a-876b-383822121af8@acm.org>
Date:   Fri, 25 Aug 2023 06:49:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
 <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
 <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
 <plrbpd5gg32uaferhjj6ibkt4wqybu3v3y32f4rlhvsruc7cu4@2pgrj2542da2>
 <783a432a-1875-d508-741d-ccc1277bb67a@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <783a432a-1875-d508-741d-ccc1277bb67a@gmail.com>
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

On 8/24/23 18:36, Bob Pearson wrote:
> Did you see Bart's comment about srp not working with older versions of multipathd?
> He is currently not seeing any hangs at all.

Hi Bob,

It seems like my comment was not clear enough. The SRP tests are compatible
with all upstream versions of multipathd, including those from ten years ago.
While testing on Debian, one year ago I noticed that the only way to make
the SRP tests pass was to replace the Debian version of multipathd with an
upstream version. I'm not sure of this but my guess is that I encountered a
Debian version of multipathd with a bug introduced by the Debian maintainers.

Bart.

