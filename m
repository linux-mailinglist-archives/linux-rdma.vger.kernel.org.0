Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C860953A32F
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jun 2022 12:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352677AbiFAKsb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Jun 2022 06:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbiFAKrk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Jun 2022 06:47:40 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858EB13E95
        for <linux-rdma@vger.kernel.org>; Wed,  1 Jun 2022 03:47:01 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-f314077115so2187702fac.1
        for <linux-rdma@vger.kernel.org>; Wed, 01 Jun 2022 03:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=4IWjHL/5Vo6JeFN3XdXq446L6FUUmY7SjaH1cuJ3kmM=;
        b=E5O90zcJSnFF/jhaT0ozVoCUxV9M4yYh3iuAVKFdq28iUKC9l/5jrhZLbsY0Lj0nWy
         bcFMSCg5m5vHZSAcCywnfWMvCpjY4nGxAmUPbxF7T3tdDMaptfNOXiu5nYrE91nVX8+o
         3Pm+Y5/TXGkP85Mhg1s7N0sPKVzjqmstiy629Ik84/vIWWO8T9rKsDoDO8mKudheMBdX
         uuvJkTV2R9bwmb8GgobTeFr5o/5PgjRbsMtQEKhtf3aMPy7MfL9jwOUT9kQgxYqteft3
         01yUBFDW2yk36M0C3o9tGVeP/NBkUyUKMQzCQioBwbvdwAJSnuiKmgg8QeoGyA33fbkD
         k1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=4IWjHL/5Vo6JeFN3XdXq446L6FUUmY7SjaH1cuJ3kmM=;
        b=QXZf+lPGn2f6qI0royuHUO/Kk4jKKto6+EMwyBX1dWsd8yKQSjhfonmdaqyvqLixmQ
         +0YkWRyCj93ECoErGJ9qOHls5bIvr2OyriBpNeP47AtXsfaQ31v8CN8JuMqUGjsNzTcg
         9i6mzyZANQ9MgfG9In+OJO0F8by1tw8n4zFO2Vw8Iv8JyVix9J0bd0Vs+OUwPwUbNNiu
         vRlD5sA97gbyq844Sxv4TaW7AAqfBk7OXimwBuWNAHP2gBBJZ8io5a9ygsWadTnHbc+T
         G8SAsmBiunm1GfWQ1ySs4UmYIVHyqlWX4vFRToLYLMIiUrcx5LZiHCKDib8aJCE8QEib
         1/Hw==
X-Gm-Message-State: AOAM532o7k80+EJaLm/R7PWNCUeR1b6iZtNGXEyHOytSdNwu5qAzowGK
        uuUDV0wjZ6CK4nmHaAl0lT/2L5s9WC1NAU+XisI=
X-Google-Smtp-Source: ABdhPJwkiIXtBazZY+P/bXlB1SpjioxSsSEqZACDgYmOca+1Kn4FY5BpotMU+owbVJyE12WhtdNqf3cRMN42Hc4SZ0U=
X-Received: by 2002:a05:6871:721:b0:f3:24af:e506 with SMTP id
 f33-20020a056871072100b000f324afe506mr9687396oap.30.1654080420760; Wed, 01
 Jun 2022 03:47:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:1893:b0:a3:3beb:ce8 with HTTP; Wed, 1 Jun 2022
 03:47:00 -0700 (PDT)
Reply-To: jbi880375@gmail.com
From:   Julian Bikarm <tastomelina@gmail.com>
Date:   Wed, 1 Jun 2022 03:47:00 -0700
Message-ID: <CAJ=LxuR2FoAZMGwCYwMJVAzGGF8c1fXQ=Wt+MsfSkGOG2mDNgA@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Dear ,

  Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Julian
