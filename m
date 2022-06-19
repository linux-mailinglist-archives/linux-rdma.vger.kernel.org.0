Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AADB55080F
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jun 2022 05:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiFSDbc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 Jun 2022 23:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiFSDbb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 18 Jun 2022 23:31:31 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA42DF8A
        for <linux-rdma@vger.kernel.org>; Sat, 18 Jun 2022 20:31:30 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id q1-20020a056830018100b0060c2bfb668eso6009018ota.8
        for <linux-rdma@vger.kernel.org>; Sat, 18 Jun 2022 20:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=XnZnNjYMTH4syOCIhrjlMWdTwRb5WDvupRx0/COS2wM=;
        b=e2phu4NndMPt72XI6GW2wwDVgrS3kqEHudVukuwN7sK6P1LlGkazC22JvMiG4Aw1CF
         46mCe3ATV9ixuwtcugugnn743EofnKbvWoRlNtJzDhwmcQnD1PNfZYEi99gQdNntblGN
         ZAiL99AgSDiUK7uh+qxcYVHV7x5Tucn8A0GvD3tENvfSDXMTBqw9kvlTXMZE9OGdzb/5
         S+vFgGOVGOZZ39Ic6zmPfNMb1wGlVd/yDctm122ulQE0Sevo16M2mRyZKnkUJkKIiik4
         Krlls6ODI/kWnR57RsuHQNUZJ4265uQdkqYTgTcZ6Or/IUCXEIlWwVPG5bDBlzy8kLUs
         sedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=XnZnNjYMTH4syOCIhrjlMWdTwRb5WDvupRx0/COS2wM=;
        b=QhZXUwUXU1IvjVnGOEmrX8mcTKh5JDb0FDqOOsJ0RD2Jn4uUX6+9/Jv2o71BRbnPiD
         92shiqzzZWudPgfI0EVkJvtgERPgATcDwRu8uyxPgvjmzKQpQDaVGJ37wpKwr/FfTP78
         AwQug0O0WLCNwTqW9r2LO4OtaaZv+FGzs5vpYrzP8kYmeCVENBtikKq6lqScfaVWEI1+
         h3shmDR54iSc+YMOzQojQza5XLUaEB51ZnI1Ib88a4dSecozaSMU7BmbNy0lzuxJuZ/k
         MA2wIK/ugJdTugb4TH91iFsmAZYZjOswFpUCztz3RV1oODOaJVpvYKtApWXpMUwuwN3k
         EiZQ==
X-Gm-Message-State: AJIora+s1HUEZf6vFMOMmOkcL+FPy7Yzh6LoVQJfbda6HL9wQyKMhliS
        yTlA37As299yoeen09TJmotMioxC6q4=
X-Google-Smtp-Source: AGRyM1ud3iwBBQQVslTDfeXhqJaY1ZYqLE1Huhpflz3qksKG0Eyr8qmJpA1v7xBzH7TQZ5W3CjqDbQ==
X-Received: by 2002:a05:6830:1188:b0:60e:32a4:349 with SMTP id u8-20020a056830118800b0060e32a40349mr6043282otq.116.1655609489400;
        Sat, 18 Jun 2022 20:31:29 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:6625:8470:de4c:3360? (2603-8081-140c-1a00-6625-8470-de4c-3360.res6.spectrum.com. [2603:8081:140c:1a00:6625:8470:de4c:3360])
        by smtp.gmail.com with ESMTPSA id u19-20020a056870951300b000f309d52933sm4963147oal.47.2022.06.18.20.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jun 2022 20:31:28 -0700 (PDT)
Message-ID: <c8dff35b-a40b-19a0-a1a0-68d5637b3709@gmail.com>
Date:   Sat, 18 Jun 2022 22:31:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Edward Srouji <edwards@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: Bug in pyverbs test_resize_cq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Edward,

In the test_resize_cq test the following is written

        # Fill the CQ entries except one for avoid cq_overrun warnings.

        send_wr, _ = u.get_send_elements(self.client, False)

        ah_client = u.get_global_ah(self.client, self.gid_index, self.ib_port)

        for i in range(self.client.cq.cqe - 1):

            u.send(self.client, send_wr, ah=ah_client)



        # Decrease the CQ size to less than the CQ unpolled entries.

        new_cq_size = 1

        with self.assertRaises(PyverbsRDMAError) as ex:

            self.client.cq.resize(new_cq_size)

        self.assertEqual(ex.exception.error_code, errno.EINVAL)


No where does it make any attempt to see if the sends are completed before testing to
resize the cq. Software drivers might not get finished in time and fail the test
because there are no entries in the cq. Technically this is wrong code. You should test
for the completion before attempting to destroy them. Or insert a small delay.

Bob
