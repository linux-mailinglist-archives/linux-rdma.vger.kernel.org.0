Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1760714EE0
	for <lists+linux-rdma@lfdr.de>; Mon, 29 May 2023 19:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjE2RTC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 May 2023 13:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE2RTB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 May 2023 13:19:01 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E02B5
        for <linux-rdma@vger.kernel.org>; Mon, 29 May 2023 10:19:00 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3942c6584f0so1060071b6e.3
        for <linux-rdma@vger.kernel.org>; Mon, 29 May 2023 10:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685380739; x=1687972739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vHUH8SX+NPR9RIStD30Jt/0ygYhBa4SLxMMiVrC//Ig=;
        b=U3jN1rbFw2khpUorSdpra7kCrcRWl4fLK5dT3n0wHNk2sFcoD2fDdW9QpVIRmRvmKM
         N3omPkI3LHRwMhz5l+mvmP7h4QuK0/AFJkki6oPmtp/M2Q+vYQSH/8ciujrcy29Mahle
         TDGSqKrd8OrxjCLBQgyqZdSUXo8hf07sPcP+lhETE8ck22xwQGa9P5JA5Huq7vvcQqY3
         y8ekzfYTmnOqM1MYGguBeWblDYE+suwf23i+vCWMJMy4yh6pzp8BuThGhnc/roUQV44S
         Rsr6gPvNDH1rINqeuVt2TpPGHikjfb566rkeqVu2ENuNUzB7He7t36UUC5XqfEgVLDag
         yaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685380739; x=1687972739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHUH8SX+NPR9RIStD30Jt/0ygYhBa4SLxMMiVrC//Ig=;
        b=VQ7+FARy1NSRQyXr2EGmf6Y+CAZnpatwqSXnEYrZNzCgztcWb3BHdZRP+iJ1hDMH5W
         uNtiiNtrEKMGH5papN8O+fr6/yAg29tucchWyA/36bMcG19ZSFAaA86l/X7gO0MF7evG
         I373MgH5fCqD9eVR4iphUIdroC0GncUx7adBmgx/p+crlI6J2T9pV0p9vDSpbBjd9qLe
         N3LVDnzhI7zLiw/+3L2Y1iNXkfzikLPOzS2aMarOshxNIGbnLD7UHrRmaXB4L2OwRxfg
         5jbi0pCvebMAs3Y6qSpbGt7+p92ChvT+H8/9thONQDC5cSIqewLTTGSfNMZxagSYMc7t
         nj4w==
X-Gm-Message-State: AC+VfDw4/PeZR13zcOgFhY9EJmugXyxIldh3HKZBjVV/wtreT6NF5B9N
        xjV/qe0Hi94+SxKjhr7Y4zGrDsUm4c9zmw==
X-Google-Smtp-Source: ACHHUZ6uA07W7J6pnC4uIWiXApo0b4nRc6+shyIJP2pX1un5R2ccvzTG+gQ5B8SI6lgSMNm0NKdIUw==
X-Received: by 2002:a05:6808:993:b0:398:560c:a4c5 with SMTP id a19-20020a056808099300b00398560ca4c5mr5004782oic.55.1685380739371;
        Mon, 29 May 2023 10:18:59 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:bd71:7fe:392d:ac1f? (2603-8081-140c-1a00-bd71-07fe-392d-ac1f.res6.spectrum.com. [2603:8081:140c:1a00:bd71:7fe:392d:ac1f])
        by smtp.gmail.com with ESMTPSA id z82-20020aca3355000000b0038de3f4e375sm4908600oiz.23.2023.05.29.10.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 10:18:59 -0700 (PDT)
Message-ID: <4478bf2f-eebd-70b6-59cc-32f7ffdb126f@gmail.com>
Date:   Mon, 29 May 2023 12:18:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: problems with test_mr_rereg_pd
To:     Edward Srouji <edwards@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, ido Kalir <idok@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <12981460-88f4-017e-be8e-f19d1dee142f@gmail.com>
 <eec66b91-d3b9-47d3-32db-cc38d4aff527@nvidia.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <eec66b91-d3b9-47d3-32db-cc38d4aff527@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/29/23 03:46, Edward Srouji wrote:
> 
> On 5/25/2023 1:22 AM, Bob Pearson wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Edward, Ido,
>>
>> The test_mr_rereg_pd pyverbs test is failing for the rxe driver.
> 
> Does rxe even support rereg? This is what I get:

I am working to implement it. Change PD and change ACCESS are working.
Change trans probably won't for now.
> 
> $ python3 tests/run_tests.py -v -k rereg_pd --dev rxe0 --gid 1
> test_mr_rereg_pd (tests.test_mr.MRTest)
> Test that cover rereg MR's PD with this flow: ... skipped 'Rereg MR is not supported (Failed to rereg MR: IBV_REREG_MR_ERR_CMD. Errno: 95, Operation not supported)'
> 
> (Your below suggested solution should be done anyway)
> 
>> I have figured out that the problem is that the following sequence
>>
>>      def test_mr_rereg_pd(self):
>>          """
>>          Test that cover rereg MR's PD with this flow:
>>          Use MR with QP that was created with the same PD. Then rereg the MR's PD
>>          and use the MR with the same QP, expect the traffic to fail with "remote
>>          operation error". Restate the QP from ERR state, rereg the MR back
>>          to its previous PD and use it again with the QP, verify that it now
>>          succeeds.
>>          """
>>          self.create_players(MRRes)
>>          u.traffic(**self.traffic_args)
>>          server_new_pd = PD(self.server.ctx)
>>          self.server.rereg_mr(flags=e.IBV_REREG_MR_CHANGE_PD, pd=server_new_pd)
>>          with self.assertRaisesRegex(PyverbsRDMAError, 'Remote operation error'):
>>              u.traffic(**self.traffic_args)
>>          self.restate_qps()
>>          self.server.rereg_mr(flags=e.IBV_REREG_MR_CHANGE_PD, pd=self.server.pd)
>>          u.traffic(**self.traffic_args)
>>          # Rereg the MR again with the new PD to cover
>>          # destroying a PD with a re-registered MR.
>>          self.server.rereg_mr(flags=e.IBV_REREG_MR_CHANGE_PD, pd=server_new_pd)
>>
>> Schedules 10 iterations of a UD send to UD receive with an invalid mr pd which does not
>> match the qp pd. So it fails with a remote operation error on the first request.
>> The remaining 9 send and receive work requests are flushed to the caller with a
>> FLUSH_ERROR but not cleared out of the completion queues.
>>
>> This is required by the IBA for Class A responder errors ("Remote operational error").
>> In C9-220 it requires:
>>
>>        All other WQEs on both queues, and all WQEs subse-
>>        quently posted to either Queue, are completed with
>>        the “Completed - Flushed in Error” status
>>
>> The final phase of the test wants to verify that after putting the original pd
>> back into the mr traffic works OK. But the remaining FLUSH errors in the completion
>> queues cause the test to fail.
>>
>> To make this test work you would have to clean the completion queues as part of
>> restate_qps but that is not done.
>>
>> Bob

