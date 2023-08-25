Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0880E788909
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Aug 2023 15:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjHYNwm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Aug 2023 09:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245295AbjHYNwg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Aug 2023 09:52:36 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD36E4E;
        Fri, 25 Aug 2023 06:52:35 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1bdbbede5d4so8265915ad.2;
        Fri, 25 Aug 2023 06:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692971554; x=1693576354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+KKKdmXIr7nxDya+WfoXRUFgR2fDdErvx83bNTM2sE=;
        b=WPrRoY2S7Iybo4Yhkxv/bmPVCh5WXEkNoFovq17l1fHh7Pft0CQ6634NDa1vp+OOHO
         o4BfOXnSxzp66sa7ZWfsiMwgGri3H0RXVfNh1KymLbFM0mNmqfLz56X33WN0mcrOgRUB
         NH8vVASgZtr+gkblGQhOQrs7ixeTH/oN159m/dtMK6QqRlwEwM35XiDSBvd5THBEObbW
         ryxxyREZuqKs22MO/8SOiV3yJVxhqaKLgoubRveF1O/yP4jbIZZuk+v5V1qGRvZL2hVI
         8M2VNWtOzO1E1bweR0lJ2V/LT4DAFahDGppSWAKsoPKR+beBB1jDZCp46WcRmaoFOduy
         8OVw==
X-Gm-Message-State: AOJu0YxQcHCZvQzqp4ZOz+vAioVNowA6UfaASu9Vq+ORsM5TJDNQZ9Ny
        m6lTEO8v+NBk2NsmG4sKhKeS9/rfj/E=
X-Google-Smtp-Source: AGHT+IHLoOWP7drgMVli/MgnvdGxGEZYqN09nhFU0sfaOPXCiBPKre7D7a4FCoS+qc8SQJClof0OOA==
X-Received: by 2002:a17:903:447:b0:1b8:971c:b7b7 with SMTP id iw7-20020a170903044700b001b8971cb7b7mr18086520plb.56.1692971554422;
        Fri, 25 Aug 2023 06:52:34 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090274c400b001b891259eddsm1711085plt.197.2023.08.25.06.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 06:52:33 -0700 (PDT)
Message-ID: <18a3ae8c-145b-4c7f-a8f5-67840feeb98c@acm.org>
Date:   Fri, 25 Aug 2023 06:52:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
 <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
 <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
 <plrbpd5gg32uaferhjj6ibkt4wqybu3v3y32f4rlhvsruc7cu4@2pgrj2542da2>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <plrbpd5gg32uaferhjj6ibkt4wqybu3v3y32f4rlhvsruc7cu4@2pgrj2542da2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/24/23 18:11, Shinichiro Kawasaki wrote:
> If it takes time to resolve the issues, it sounds a good idea to make siw driver
> default, since it will make the hangs less painful for blktests users. Another
> idea to reduce the pain is to improve srp/002 and srp/011 to detect the hangs
> and report them as failures.

At this moment we don't know whether the hangs can be converted into failures.
Answering this question is only possible after we have found the root cause of
the hang. If the hang would be caused by commands getting stuck in multipathd
then it can be solved by changing the path configuration (see also the dmsetup
message commands in blktests). If the hang is caused by a kernel bug then it's
very well possible that there is no way to recover other than by rebooting the
system on which the tests are run.

Thanks,

Bart.
