Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113726C75F7
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Mar 2023 03:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCXCic (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Mar 2023 22:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCXCic (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Mar 2023 22:38:32 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0670C1588B
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 19:38:30 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id bj20so368502oib.3
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 19:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679625510;
        h=content-transfer-encoding:in-reply-to:from:to:references
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5PDWEHeHVhC/41hzMKzG13okIfQ0/xarVHK1KJr1JQg=;
        b=ZD3SA5ABFBt0puEbkWlffp57J4EGqPYFKVZZOtef16c0xzjazsw7nMeHMx/RVx38Rh
         hlc/LHVWykVmqIJZf3T5e/IzUzavANNNso8t1nEo7wIUBgTXhQh7VPcw22KQKqJA6Wmn
         +SY+mRyu75Zfy7sEX5aIA/lv5sJ+TbvawjNShvMl7AZPz11uQ3ZLiJkj1GZ+teIjX2MT
         Yoy+WAsPCMp7FPetN7waP3VI/QpegZ4W82zbCocJ/wPCsO8/xueDszeZCH+3h4q1ruCq
         MJjxGzipNCmy2QLsLgmAM5oySuXlmiv4QMVZvWQfERX98VYv76XGKzCyb7S6+SIEmPt3
         QcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679625510;
        h=content-transfer-encoding:in-reply-to:from:to:references
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5PDWEHeHVhC/41hzMKzG13okIfQ0/xarVHK1KJr1JQg=;
        b=K98K2Cq2PIlflMSBsycgB6LEXPsW8KGMyXIuzzKeX2mURVsXXqS5VW+RLv1uSbl2//
         p44cCizSbZi7YBsXwjEw82w+X6a+nUoI409LgWixLIoJyg4QEDBWJ+XPTrzCxE8/n4SM
         LshuXeVMyRxLQDvYdu8VbqvJTLFrjrSnUCmSog7SUCRXnK9HimrKEyB1kxlIvXFw98dv
         TTU3BtBVf8z/Vgnt4iwLYa7E/LroV7e4sJejuacY9mW2X6FLdNiPHvcZvAHzcbZCWn1p
         9Hw9OrIOrBX3TDI0wgPsWJo0ypMwWo03TXI8EshNMNcV0cP/jdy8baTnkxLVgH/w6nvw
         N5Lg==
X-Gm-Message-State: AO0yUKV1K4IlWwfqhnJgPFbu0WCeCeQ004mkONMZNOd2WlCx2K7YU9ZI
        +y8hV2hF/lveNCdFKNfRsbc0syS10i8=
X-Google-Smtp-Source: AK7set+lq1Ps7WG6hp22r/xFFUP1NT5x6FvE1Qme3LKoAgDfk1jbEFpbxHPt7mp4fN6fAhcWxNP9vQ==
X-Received: by 2002:a54:4792:0:b0:387:1b0f:c03e with SMTP id o18-20020a544792000000b003871b0fc03emr316814oic.17.1679625509907;
        Thu, 23 Mar 2023 19:38:29 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:1c3a:5f4c:c6c8:a181? (2603-8081-140c-1a00-1c3a-5f4c-c6c8-a181.res6.spectrum.com. [2603:8081:140c:1a00:1c3a:5f4c:c6c8:a181])
        by smtp.gmail.com with ESMTPSA id s4-20020a0568080b0400b0038755008179sm1658994oij.26.2023.03.23.19.38.28
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 19:38:29 -0700 (PDT)
Message-ID: <b43c8172-a1c3-2ebd-e70e-198ae68248b5@gmail.com>
Date:   Thu, 23 Mar 2023 21:38:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Fwd: pyverbs test_resize_cq fails in some cases
Content-Language: en-US
References: <f218337a-b975-bfa7-635d-bafc42c2df04@gmail.com>
To:     linux-rdma@vger.kernel.org
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <f218337a-b975-bfa7-635d-bafc42c2df04@gmail.com>
X-Forwarded-Message-Id: <f218337a-b975-bfa7-635d-bafc42c2df04@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org




-------- Forwarded Message --------
Subject: pyverbs test_resize_cq fails in some cases
Date: Thu, 23 Mar 2023 21:37:28 -0500
From: Bob Pearson <rpearsonhpe@gmail.com>
To: Edward Srouji <edwards@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>

Edward,

The pyverbs test: test_resize_cq fails for the rxe driver in some cases.

The code is definitely racy:

def test_resize_cq(self):
        """
        Test resize CQ, start with specific value and then increase and decrease
        the CQ size. The test also check bad flow of decrease the CQ size when
        there are more completions on it than the new value.
        """
        self.create_players(CQUDResources, cq_depth=3)
        # Decrease the CQ size.
        new_cq_size = 1
        try:
            self.client.cq.resize(new_cq_size)
        except PyverbsRDMAError as ex:
            if ex.error_code == errno.EOPNOTSUPP:
                raise unittest.SkipTest('Resize CQ is not supported')
            raise ex
        self.assertTrue(self.client.cq.cqe >= new_cq_size,
                        f'The actual CQ size ({self.client.cq.cqe}) is less '
                        'than guaranteed ({new_cq_size})')

        # Increase the CQ size.
        new_cq_size = 7
        self.client.cq.resize(new_cq_size)
        self.assertTrue(self.client.cq.cqe >= new_cq_size,
                        f'The actual CQ size ({self.client.cq.cqe}) is less '
                        'than guaranteed ({new_cq_size})')

        # Fill the CQ entries except one for avoid cq_overrun warnings.
        send_wr, _ = u.get_send_elements(self.client, False)
        ah_client = u.get_global_ah(self.client, self.gid_index, self.ib_port)
        for i in range(self.client.cq.cqe - 1):
            u.send(self.client, send_wr, ah=ah_client)

	### This posts 6 send work requests but does not wait for them to complete
	### The following proceeds while the sends are executing in the background
	### and the test can fail. An easy fix is to add the line
        time.sleep(1/1000)  ### or maybe something a little larger but this works for me.
	### alternatively you could test the data at the destination.

        # Decrease the CQ size to less than the CQ unpolled entries.
        new_cq_size = 1
        with self.assertRaises(PyverbsRDMAError) as ex:
            self.client.cq.resize(new_cq_size)
        self.assertEqual(ex.exception.error_code, errno.EINVAL)

Bob
