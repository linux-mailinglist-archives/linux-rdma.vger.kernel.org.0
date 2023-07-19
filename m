Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCC4759A89
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jul 2023 18:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjGSQOi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jul 2023 12:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjGSQOi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jul 2023 12:14:38 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B4710B
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jul 2023 09:14:36 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1b059dd7c0cso5612276fac.0
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jul 2023 09:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689783275; x=1692375275;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n+yr0SwLIJTZ+rjKL48fZL6dhCm6tOlZQ6MYdakXIkk=;
        b=GuUHc4ZXOKEkrhWJPUvXtrKyVvelzR/bRUY+uxqc73qIb/37pMCKtOjcbhWgaIML6E
         7HDg8XTK1dOJgLiqCp8jKkbgRR+O8fBubG6jkioibTq5ErXYXvThX//gONiECKh+Rsx3
         uNKZdXkxoo04uwe+yV68Cyx6lQZvOInoJT/8BKAFkOi+sHEHtPQ+ubr0cml3fgXWaikF
         qQ8Sj0R5M5MXXMZPsjVnDPk761GMe3RRDjrcZ/UefwCooEi0ncfjcaQl0L81v3CNGsTa
         nser9SMO030cLwGXnaEJV3v4fnBiDkuTlsWiMWfGLz2t4ApyQjb0uhxKOWgwnG/XLsi8
         XnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689783275; x=1692375275;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+yr0SwLIJTZ+rjKL48fZL6dhCm6tOlZQ6MYdakXIkk=;
        b=ceRQTyRrhUxx7BdmGKws5x7XwlHnhByNbgK9xmS9HUe2CPMbqAnSea7YWxUfapL0jc
         Czm25LTJsgC3An6LOkOby/nV/YslFrxtrsKYwaP/N814p7hBjzd1VWijz4FiM4PvApyv
         ManpBewRy1ueGaRsQtirg9Tc5ot4Vp7Mez2UCzdUPFZHRuSxYy06uY0Pg27VktKM2umX
         ELVXcF40QRoG7fMlvAApJAy4gHbEc+uxzJESeHY4B353g6fQKufdNwF+wWXDKUhcVS9I
         elfspQ7epAmPiFOH+sz4XcwqP1J25t1q6pBwqdRNS6JfVoshQfdVAApho7J6PCw228PY
         uHWg==
X-Gm-Message-State: ABy/qLbwPyyA/2iyh0Zo3smV/sEx4EkD6BMA704nTwQGy9cpq0jNpgf3
        pIiLAgSGBMqt0Je5npqIYxQfSsgAGyA=
X-Google-Smtp-Source: APBJJlF0fzZQAjPCNXRybA6ZMOsbWfTJIwZyo02/my5TChjSvNFcGvqW2SyuNqByuWOKr2YT/LARWw==
X-Received: by 2002:a05:6870:6003:b0:1b0:5141:4c6e with SMTP id t3-20020a056870600300b001b051414c6emr23716019oaa.26.1689783275249;
        Wed, 19 Jul 2023 09:14:35 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:6b28:6b74:44a5:2cfa? (2603-8081-140c-1a00-6b28-6b74-44a5-2cfa.res6.spectrum.com. [2603:8081:140c:1a00:6b28:6b74:44a5:2cfa])
        by smtp.gmail.com with ESMTPSA id w1-20020a056870854100b001b3d93884fdsm2045428oaj.57.2023.07.19.09.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 09:14:34 -0700 (PDT)
Message-ID: <8f924d85-1ca7-d51a-d8ed-d019957244f1@gmail.com>
Date:   Wed, 19 Jul 2023 11:14:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Fwd: pyverbs test_resize_cq fails in some cases
Content-Language: en-US
To:     Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>
References: <f218337a-b975-bfa7-635d-bafc42c2df04@gmail.com>
 <b43c8172-a1c3-2ebd-e70e-198ae68248b5@gmail.com>
 <a958a957-dfe3-9348-632f-ee0c9af13238@gmail.com>
 <94b33c65-e0b5-663a-f041-3b96df3ef977@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <94b33c65-e0b5-663a-f041-3b96df3ef977@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/18/23 10:13, Edward Srouji wrote:
> 
> On 7/18/2023 5:08 AM, Bob Pearson wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 3/23/23 21:38, Bob Pearson wrote:
>>>
>>>
>>> -------- Forwarded Message --------
>>> Subject: pyverbs test_resize_cq fails in some cases
>>> Date: Thu, 23 Mar 2023 21:37:28 -0500
>>> From: Bob Pearson <rpearsonhpe@gmail.com>
>>> To: Edward Srouji <edwards@nvidia.com>
>>> CC: Jason Gunthorpe <jgg@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
>>>
>>> Edward,
>>>
>>> The pyverbs test: test_resize_cq fails for the rxe driver in some cases.
>>>
>>> The code is definitely racy:
>>>
>>> def test_resize_cq(self):
>>>          """
>>>          Test resize CQ, start with specific value and then increase and decrease
>>>          the CQ size. The test also check bad flow of decrease the CQ size when
>>>          there are more completions on it than the new value.
>>>          """
>>>          self.create_players(CQUDResources, cq_depth=3)
>>>          # Decrease the CQ size.
>>>          new_cq_size = 1
>>>          try:
>>>              self.client.cq.resize(new_cq_size)
>>>          except PyverbsRDMAError as ex:
>>>              if ex.error_code == errno.EOPNOTSUPP:
>>>                  raise unittest.SkipTest('Resize CQ is not supported')
>>>              raise ex
>>>          self.assertTrue(self.client.cq.cqe >= new_cq_size,
>>>                          f'The actual CQ size ({self.client.cq.cqe}) is less '
>>>                          'than guaranteed ({new_cq_size})')
>>>
>>>          # Increase the CQ size.
>>>          new_cq_size = 7
>>>          self.client.cq.resize(new_cq_size)
>>>          self.assertTrue(self.client.cq.cqe >= new_cq_size,
>>>                          f'The actual CQ size ({self.client.cq.cqe}) is less '
>>>                          'than guaranteed ({new_cq_size})')
>>>
>>>          # Fill the CQ entries except one for avoid cq_overrun warnings.
>>>          send_wr, _ = u.get_send_elements(self.client, False)
>>>          ah_client = u.get_global_ah(self.client, self.gid_index, self.ib_port)
>>>          for i in range(self.client.cq.cqe - 1):
>>>              u.send(self.client, send_wr, ah=ah_client)
>>>
>>>        ### This posts 6 send work requests but does not wait for them to complete
>>>        ### The following proceeds while the sends are executing in the background
>>>        ### and the test can fail. An easy fix is to add the line
>>>          time.sleep(1/1000)  ### or maybe something a little larger but this works for me.
>>>        ### alternatively you could test the data at the destination.
>>>
>>>          # Decrease the CQ size to less than the CQ unpolled entries.
>>>          new_cq_size = 1
>>>          with self.assertRaises(PyverbsRDMAError) as ex:
>>>              self.client.cq.resize(new_cq_size)
>>>          self.assertEqual(ex.exception.error_code, errno.EINVAL)
>>>
>>> Bob
>> Edward,
>>
>> This is showing up again. The software drivers are slower than the hardware drivers.
>> Now that the send side logic in the rxe driver is handled by a workqueue and if it is
>> scheduled instead of running inline this test will fail some percentage of the time.
>> Especially when the test is run for the first time but 5-10% of the time after that.
>> If you run the send side logic inline it is fast enough that the test doesn't fail but
>> that doesn't allow the workqueue tasks to spread out on the available cores so for high
>> QP count it is much better to schedule them.
>>
>> There are a few time.sleep(1) calls in the pyverbs test suite but that is wasteful and
>> better is time.sleep(0.001) which works fine for this test and doesn't slow down the
>> run time for the whole suite noticeably.
> 
> I prefer not to add a sleep (the only sleeps are in mlx5_vfio test which is required to wait for the port to become up - but it's not run by default until the user specifically configure an mlx5_vfio device).
> 
> What if we poll the CQ for one completion, to make sure that the driver had the time to publish a CQE (which might be enough "time" for us)?
> i.e.
> 
> $ git diff
> diff --git a/tests/test_cq.py b/tests/test_cq.py
> index 98485e3f8..e17676304 100644
> --- a/tests/test_cq.py
> +++ b/tests/test_cq.py
> @@ -123,6 +123,7 @@ class CQTest(RDMATestCase):
>          ah_client = u.get_global_ah(self.client, self.gid_index, self.ib_port)
>          for i in range(self.client.cq.cqe - 1):
>              u.send(self.client, send_wr, ah=ah_client)
> +        u.poll_cq(self.client.cq)
> 
>          # Decrease the CQ size to less than the CQ unpolled entries.
>          new_cq_size = 1
> 
> Could you try to see if that solves the issue for you?
> 
>>
>> Bottom line this test case is racy.
>>
>> If you want I can submit a 2 line patch that does this. Or if you would that would be
>> better.
>>
>> Bob

Yes. May take a day or two to get to it but I will definitely try it.

Thanks

Bob
