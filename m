Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F73124937D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Aug 2020 05:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgHSDkV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 23:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgHSDkU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 23:40:20 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1A1C061389
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:40:20 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id v21so17988315otj.9
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m60b5bpXq6doujMwNMIuMyIMbfV66Xc17V20SAT3dfM=;
        b=TuoaapC1FIHe0/Yx8fNM8TBMjbqyyrQ37RCPX6gwAasPdt/qE2nBRbjhV5ZCwll9KK
         p9qbzEGRVBn8ryRSC90hdjQa3v7WdZtQF90BfNDscu2FLLFhqemJ2IGCRG1WkIhoXXBc
         cUd2hk4v+1/UkuqU24vMMK/TK3MNxSKGkXf1Sb0z8Szrslb3/KMLK2y8bzY5OyOAhYiM
         F08LOK8rqiyNOYYDvNfBLqURblwki0wGwrIq14H/KYMNhtVmoS8eV2GlNOfE8HllCVdS
         5qu5uF7745oRGehcg644GAHUy/TvUw09F4BA+zAazz+4PIWPMT0yJfd2fgIYw37RsySW
         wuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m60b5bpXq6doujMwNMIuMyIMbfV66Xc17V20SAT3dfM=;
        b=nJz+lbyDpkta8d7eQ2RkC7w34UUJN+yN1okDqJNDHfhmBxfUnJdVIy4DThHK7O1221
         BN24VnUmKcmAqx94xw2RSrQbe2NKCLM6XXG9onT85hp5N3Tpe1xO7KwrqLTGwQd1G1m6
         kgE2oeJH4Sb26CANKjrlTPcdzcq4xA6TJRckLAf5dJ/Lx/oeWtlEU59ND8N/hqA19olz
         ui0/PdmRDdReZIpNgYyr9dteawVP5rqupL7WP3alQ01+qS3SBJMOuisvEn4fMtasoXSg
         9xj6nYnFH+JF8mIHe64ZuK3k+EvO0PRZkckMBZE3BGzH1cx0VTuY69rLp4fMADxVFBh9
         jTog==
X-Gm-Message-State: AOAM533FR5bcgE+EM8Cbre2RKLXrY92e/BFGRtl5tKUHWcDD4CtKGc3C
        mC3N7fKiuk4CnPL3ZrdsNCeHV1YwZEn9MQ==
X-Google-Smtp-Source: ABdhPJyTGPaBF0K43/v5j7j88zDILPw6oTRPpjNLgJ5e+PnZMo39IMuu4CTQjSkRj8Zp2wknHQ8Mdw==
X-Received: by 2002:a9d:1d68:: with SMTP id m95mr18002263otm.110.1597808417557;
        Tue, 18 Aug 2020 20:40:17 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:2731:80e6:14c6:1150])
        by smtp.gmail.com with ESMTPSA id k73sm4381788oih.57.2020.08.18.20.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 20:40:17 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Memory window support for rdma_rxe
Date:   Tue, 18 Aug 2020 22:39:46 -0500
Message-Id: <20200819034002.8835-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This a cleaned up resend of an earlier patch set. This set of patches
implements the memory windows verbs and local send operations. Each of these
has been tested at a basic level and regressions tests have been run to
see that basic rxe functionality is OK.

The main difference between v2 and v1 is that each patch passes checkpatch
and compiles without errors. Also, this set was ported from Linus's head of
tree the the rdma-kernel tree because the last ones had problems getting
cleanly applied. (I am trying to get git send-email to use -v2)

I would encourage anyone who has test cases for MWs to run them against
this code and let me know if anything crops up.

There is a matching patch for rdma-core the user space library that is required
to run user space MW applications. It will be sent out shortly.

The first two patches clean up checkpatch warnings for the existing rxe source
code. They can be used separately if desired.

The third and fourth patches are a prerequisite for the rest of the set and
add some WR and WC opcodes to ib_verbs.h and ib_user_verb.h.

Bob Pearson


