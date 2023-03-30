Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7238E6D12D9
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Mar 2023 01:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjC3XKb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 19:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjC3XKa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 19:10:30 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79BFFF1D
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 16:10:29 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id d8so12356998pgm.3
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 16:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680217829;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D2OWEPNcN/eGfBMdcdT7gVMHL93fuK94pxgzkVdQedM=;
        b=U6x35sxixOXXVTtBGncOPN12NNUBn5engPgvMSKnev5xCsb4uzB3Luvt77tTCWdjI9
         ZgOFkpEsrAJ5KREYQTy2OYZGYDml96rFGtBhlT6GZIO/8oC9on5jZKqsDTUj9nHwzoIU
         qhILcmHveclIqkb+3okNzfD/4BQVWNjOCPfQJrIlSIA+fb5zu2mA/FlassPaKAqvE7ni
         MLMa47Us3DbK7jQd+pAqH0agExk2yu0k+KrDTBHGnxWcGtAHorUOseMw2CDaN4gy6i8y
         Ux8UaRvdO3ezZoUyXnaydt6DN8nU4mwkr7zNAeHtNPfvFiIcOzdXxaB2mEkKqDkHv2wJ
         87yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680217829;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D2OWEPNcN/eGfBMdcdT7gVMHL93fuK94pxgzkVdQedM=;
        b=QDRqQy8EL2bDbBz5F8x/zzAweGQ/RLj6Cp8UDBql9atXuUWwIsD1nhTkJF9XmD6SUW
         hG5ZWaeW64oJkdSAs4cKOc+7MNvxEpkHGGGypWqqpq9gToIrl5EnVNNx4goJ49J6E0uB
         eAMcVfTuGWyw169xlZsBQKHaL+BgtkJgk+TsGNHywa1O8e06KAnmhTnQMHEXZgRsrlSB
         LOlipFRuLY2q2jGhSnyO/4ud+Z0QxrI7UsS77dO5QCio4X7Q/h4TF1IMSe+D76Ymdatd
         7Y3AflyLviSWlI/+ULIENKS2zzvogwiP81jAsR9AsKc64TJnRUM0Zfmmz62PpVniykay
         7XqQ==
X-Gm-Message-State: AAQBX9fUpemLtJg1q+f5Pb7ygcZM1SYh70OPeSm6WqTEbGNqMk6M03Cq
        HuOZwQlxrZ3QfjuRpORof8iquTgD1VjuIA779JY=
X-Google-Smtp-Source: AKy350YsVj3cSZvgYG4w4QjWNUH/nxVvnqpNwTK5z8+XGA3veMvsKv0iu3PfWzALFxtlVPStmPbg9H+cRpifxSCI3b4=
X-Received: by 2002:a05:6a00:1881:b0:625:d7e6:51a0 with SMTP id
 x1-20020a056a00188100b00625d7e651a0mr13662499pfh.1.1680217829098; Thu, 30 Mar
 2023 16:10:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:5009:b0:cd:fd38:df8d with HTTP; Thu, 30 Mar 2023
 16:10:27 -0700 (PDT)
From:   Kim Chang <changkim860@gmail.com>
Date:   Thu, 30 Mar 2023 16:10:27 -0700
Message-ID: <CAJVUiWoshReSv3f5CxLF3A6oQdcAFmJBz4rw8yP9gnODD3uAUQ@mail.gmail.com>
Subject: Greetings from Ukraine
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

My name is Kim Chang, I am working with the Humanitarian office of the
Red Cross and volunteer service in Kyiv, Ukraine. I have something
that would be considered to be of interest to us. I would like us to
discuss about it.
Please, kindly contact me for more details through this email
chankimberley04@gmail.com.

Thanks
Kim Chang.
Velyka Vasylkivska St,
Kyiv, Ukraine, 03150.
