Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25C77CCAF3
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 20:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjJQSpD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 14:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjJQSpC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 14:45:02 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FF2D3;
        Tue, 17 Oct 2023 11:45:01 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3af608eb367so3939099b6e.2;
        Tue, 17 Oct 2023 11:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697568300; x=1698173100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U7TFitmj5r6Fuj/tUyxl2eAZkPWcGe7AIu7cr994odc=;
        b=gpCeQXRs8Jz/ob0YxsM6aETy60iBBVDLnjmKqqwopKGGJrh7DFjqSXC4vsJ37C7jQi
         3v8gdes29xUVlqPwXNigDTWObOd6T0ZOfJTmPf6xM5IOVySiz4I6V3X8XjTUQ6VFE83m
         F9x7UIxsfL/p629olmXfL9hX9QUFzv6UzfPCTCPIAX2weAettbB1o84J0SfYBHn3VLpW
         /Mc/i0rtEgk9c+vNT/6aToxNAthm9nPNXX4WMVTMnCjIyGoEr8JZzLqs/pCFBOK/2Fu2
         AgLI8ruSIhDRszr6BsRYDR5ZFc+zgzHayB218S9nX4rpj8KvrdfxgwoM5ScwaE45mOKb
         5RWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697568300; x=1698173100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7TFitmj5r6Fuj/tUyxl2eAZkPWcGe7AIu7cr994odc=;
        b=wLKONUDdj6fBrqPvtVNMb8T2TVR7lIL1kd3Q9XqniUTGRL8hGe4yb6V3O81WyEapQo
         h0aK0vV5A/7UPOzFSVH1nRxh+sJso0O4HWmEg4PYzDFE2J525/UKVDhOMqnVAIDHNE5v
         IK9Qrrm1QDsF4bykcnmgq6YdfQiQcV9RNHB6XTF8vsRXhiORVVU7VibYK7w20kABHLQo
         hkOQnEo4RqEWnEUKTbg4omcXXgJYZHjCISqFDKaYnnhCJ0rgOhY6UQ0wwM6r3PBXpmGT
         enzhHO0VTkU3+3UC1r07Cd0JrJ2LM+WcBrv1tiHK82AVcVjemO4VLbZpjwQBwV0tAjvr
         CGjw==
X-Gm-Message-State: AOJu0YxSJrbIfRHnDCfVUv2KerXIewop6UyDOg8YVAqnkenikT8maT0e
        eaGmg+kWYgsOHDM1W5whlAU=
X-Google-Smtp-Source: AGHT+IEUR3GJxAPE+urW/ws5lWs2fIVCs1fbu5IALtZAQf4fl/LW6MEVx3tmPy4LZqMwwBwsH8cUGA==
X-Received: by 2002:a05:6808:19a4:b0:3a7:8e05:1697 with SMTP id bj36-20020a05680819a400b003a78e051697mr3550924oib.59.1697568300328;
        Tue, 17 Oct 2023 11:45:00 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:4a90:522a:952e:515c? (2603-8081-1405-679b-4a90-522a-952e-515c.res6.spectrum.com. [2603:8081:1405:679b:4a90:522a:952e:515c])
        by smtp.gmail.com with ESMTPSA id u25-20020a544399000000b003a9ba396d62sm352145oiv.36.2023.10.17.11.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 11:44:59 -0700 (PDT)
Message-ID: <8801fc68-0e8e-4bb1-acaa-597bf72a567d@gmail.com>
Date:   Tue, 17 Oct 2023 13:44:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Bart Van Assche' <bvanassche@acm.org>,
        'Rain River' <rain.1986.08.12@gmail.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <b80dae29-3a7c-f039-bc35-08c6e9f91197@gmail.com>
 <CAJr_XRAy4EHueAP-10=WSEa46j2aQBArdzYsq7OqSqR93Ue+ug@mail.gmail.com>
 <8aff9124-85c0-8e3b-dc35-1017b1540037@gmail.com>
 <3c84da83-cdbb-3326-b3f0-b2dee5f014e0@linux.dev>
 <4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com>
 <CAJr_XRCFuv_XO3Zk+pfq6C73CgDsnaJT4-G-jq1ds3bdg76iEA@mail.gmail.com>
 <OS7PR01MB1180450455E624D5CD977C461E5FCA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <29c5de53-cc61-4efc-8e8d-690e27756a16@acm.org>
 <OS7PR01MB118045AD711E93D223DCD6F17E5C3A@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <a3be5e98-e783-4108-a690-acc8a5cc5981@gmail.com>
 <20231017175821.GG282036@ziepe.ca>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20231017175821.GG282036@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/17/23 12:58, Jason Gunthorpe wrote:
> On Tue, Oct 17, 2023 at 12:09:31PM -0500, Bob Pearson wrote:
> 
>  
>> For qp#167 the call to srp_post_send() is followed by the rxe driver
>> processing the send operation and generating a work completion which
>> is posted to the send cq but there is never a following call to
>> __srp_get_rx_iu() so the cqe is not received by srp and failure.
> 
> ? I don't see this funcion in the kernel?  __srp_get_tx_iu ?
>  
>> I don't yet understand the logic of the srp driver to fix this but
>> the problem is not in the rxe driver as far as I can tell.
> 
> It looks to me like __srp_get_tx_iu() is following the design pattern
> where the send queue is only polled when it needs to allocate a new
> send buffer - ie the send buffers are pre-allocated and cycle through
> the queue.
> 
> So, it is not surprising this isn't being called if it is hung - the
> hang is probably something that is preventing it from even wanting to
> send, which is probably a receive side issue.
> 
> Followup back up from that point to isolate what is the missing
> resouce to trigger send may bring some more clarity.
> 
> Alternatively if __srp_get_tx_iu() is failing then perhaps you've run
> into an issue where it hit something rare and recovery does not work.
> 
> eg this kind of design pattern carries a subtle assumption that the rx
> and send CQ are ordered together. Getting a rx CQ before a matching tx
> CQ can trigger the unusual scenario where the send side runs out of
> resources.
> 
> Jason

In all the traces I have looked at the hang only occurs once the final
send side completions are not received. This happens when the srp
driver doesn't poll (i.e. call ib_process_cq_direct). The rest is
my conjecture. Since there are several (e.g. qp#167 through qp#211 (odd))
qp's with missing completions there are 23 iu's tied up when srp hangs.
Your suggestion makes sense as why the hang occurs. When the test
finishes the qp's are destroyed and the driver calls ib_process_cq_direct
again which cleans up the resources.

The problem is that there isn't any obvious way to find a thread related
to the missing cqe to poll for them. I think the best way to fix this is
to convert the send side cq handling to interrupt driven (as is the case
with the srpt driver.) The provider drivers have to run in any case to
convert cqe's to wc's so there isn't much penalty to call the cq
completion handler since there is already software running and then you
will get reliable delivery of completions.

Bob
