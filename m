Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943A74E2341
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Mar 2022 10:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345798AbiCUJZw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Mar 2022 05:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345781AbiCUJZw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Mar 2022 05:25:52 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433A93CA7D
        for <linux-rdma@vger.kernel.org>; Mon, 21 Mar 2022 02:24:27 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m3so11613907lfj.11
        for <linux-rdma@vger.kernel.org>; Mon, 21 Mar 2022 02:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=W1+KrZyNuTw/v7AjFu8Vox2dnLxPDFweN/7+9hyXGIZBJDplr4WHyBzM8scBzA6l7f
         BGUk56zLxUnBtv1QUXibVDQ+YHuPYpjXPzWYlHHXvU5+t3K6WpSKdPNSCbWfREISoRyu
         idcuTFcYQPVP7h4dZGSgR1E2QzUTjXU6uzFvzPuvzatsAi+61X+MOjYd8qt6B+QnMiC5
         u3Z6P9Z2QCJC0VhzqlKv70GWcQADDTV7vL8VKivWfyL1Ku0T2ttFhxM8zY3WkePKTtMX
         Tt8l8ocz4JbHnIxM3TLH56v2tRNYrq/ZWoAd0SutRzcn3iFSmke7kzbBXn0Maedta+zD
         s5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=wAV9do1B7b9RQhlfzQBsSjyDEQIFx0ahIx8qi5+LKJUhZzYQbP973XQzBGRd88RM4Z
         A6sfqF6NAAHYS/NT/3iM156TRn4U1zjY9k5pFzypoIyv7nfttNRrAP6HdhEoxUDSzN+J
         3ajjkE2f3k0cCIdb7pAfBkTWQ0c1XkWwER2PiF0/a2egacXmuVOPBK5leWuXM+IGrdpT
         QHT5WdNP+nZF0eUWPIbAzchbTiAhhxYObo2VUxU7GVOibTi25FOmHxw4BKVhJKuP8320
         ZgVqha221+pwXBWBTkF7MxI7/pP3DuRM0MAGplL4ELHSzcN4OEEgbhlejeCWq3+El2oK
         TCuA==
X-Gm-Message-State: AOAM533JPUa4Z1u70mUkKubnQrV1DoKN68lVFi99nyKRya5z9aF0qylF
        xavIEhYD7J+XF4tZCzjBYa070WCLyObA3RNUvXQ=
X-Google-Smtp-Source: ABdhPJxQRu0KB9whnmMClUDP/E6ZSqiJTqyTlp+0fjv6L0yMq/ANl7p+hA9ffdkpmnB5l3ZDDHOJOP2uS+Uy4E3uXX4=
X-Received: by 2002:a05:6512:260f:b0:44a:2580:68ad with SMTP id
 bt15-20020a056512260f00b0044a258068admr4707989lfb.9.1647854664971; Mon, 21
 Mar 2022 02:24:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:3f8c:0:0:0:0 with HTTP; Mon, 21 Mar 2022 02:24:23
 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <raqsacrx@gmail.com>
Date:   Mon, 21 Mar 2022 02:24:23 -0700
Message-ID: <CAP7=Wk6NOPha0Eenvn=8zwg0x3b47JcNjSrfKpFHj9WnU=oHBQ@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:141 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4403]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [raqsacrx[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
