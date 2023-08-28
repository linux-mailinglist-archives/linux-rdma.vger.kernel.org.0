Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1565278ADEC
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Aug 2023 12:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjH1Kwq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Aug 2023 06:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjH1Kwk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Aug 2023 06:52:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11CCCF0;
        Mon, 28 Aug 2023 03:52:07 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693219905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Shw6L4hIM6NdCogVN/OfbxVTyZ7kVU78bQFuDvYBnc4=;
        b=KiTnh2dTqEkfL3RuDHtjVkNbw7ZbDPrGjJ51HUP7Q7VaSvKwdEyWGsjVK/cUhEiNB5idq9
        uz/B/EAIFO0oHq8DKZiGcvH7GLzf2y5OjWtQorbGl5HWjGqKoZ1ziOu2ICuLpomq/qv5c6
        QOBxFT0oeE7hMxB4ZbvBXL3AQf6ei3WKu8BViAkK/sQrQz8NE2TB7U7EHh8sXACCKh38hB
        zjWWvitifdc3JzyryeR2SGcuHRXPmlaLP9wkEpcDo6CW9u4rjvD/oAFkZ13ibUBoaYHJ4E
        2JI4tedi6WX/sVIp9uKTG90Lqn6Ue/YTg6jDPiPm0N+nHettRrH5+pFkDDZ5cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693219905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Shw6L4hIM6NdCogVN/OfbxVTyZ7kVU78bQFuDvYBnc4=;
        b=kipFyot1x9kbN5bYEhWFb6QTzahH7fbQ0RJ5+H/3dWvrb7W1RlybfjvPsWFSJb857jkZvs
        +pBPynKoOEJe6KCg==
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Li Zhijian <lizhijian@fujitsu.com>, linux-rdma@vger.kernel.org,
        "pmladek@suse.com" <pmladek@suse.com>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>, jgg@ziepe.ca,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        rpearsonhpe@gmail.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Improve newline in printing messages
In-Reply-To: <CAD=hENcu4wKELCt61O+p-RtOpaHHoaAQhr7Ygt9pdr9Hc4s2Wg@mail.gmail.com>
References: <20230823061141.258864-1-lizhijian@fujitsu.com>
 <f3f30d46-379a-8730-5797-400a77db61c3@linux.dev>
 <87r0nnczp7.fsf@jogness.linutronix.de>
 <CAD=hENcu4wKELCt61O+p-RtOpaHHoaAQhr7Ygt9pdr9Hc4s2Wg@mail.gmail.com>
Date:   Mon, 28 Aug 2023 12:57:43 +0206
Message-ID: <87fs43cudc.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023-08-28, Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
> Do you mean "a newline can help flushing messages out"?
> That is, in printk, the message will be buffered until it is full or
> it meets a newline?

Correct. A trailing newline is needed for the record to become
"finalized". Only finalized records are pushed out to consoles.

If there is no trailing newline, the message will be buffered until
printk is called using a message with a trailing newline.

There are some other reasons why it may be flushed. But for sure the
flushing will be delayed if there is no trailing newline.

John Ogness
