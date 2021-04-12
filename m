Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F50A35C408
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Apr 2021 12:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239344AbhDLKbw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 06:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239218AbhDLKbu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Apr 2021 06:31:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5996FC061574
        for <linux-rdma@vger.kernel.org>; Mon, 12 Apr 2021 03:31:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a4so12368828wrr.2
        for <linux-rdma@vger.kernel.org>; Mon, 12 Apr 2021 03:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:message-id:subject:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=Mh+QZ/o6zdwL/uKfgbR29RJ8uTjxSRnfHBwvdQloXCU=;
        b=MpH+sH5Wktxg1fddSKs9pPZdljYfzPi7noSwrZ1sbYfACJBB+xa4d4BmqGzdhlv2Ho
         +1/m5IMk/liQq2MQjvik4ZVDvSYvTk1BAU305yplJkEAEJSwdBPTQFINGOvBldXlWu3Y
         xqn8xPwAzTHRja7G1UcF2Y+1qXhwtOy+8vYu26w3wFh5GG1MK3XgTUoim0b7QjUSIL6+
         Gfo6atejekotPWMYkeFxt9g3yu4MuMQ1EN4hXSwJewCu+BPiUpm7sf+YOqJKYPIv5FQC
         6PUqt03YXtedHC1CfOjvhg/t4K2CTWCwVHZCiCsx/Uuy238vN8ZwGd7LVGeAuHjOUE+m
         7p9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:subject:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=Mh+QZ/o6zdwL/uKfgbR29RJ8uTjxSRnfHBwvdQloXCU=;
        b=SQaKdS4cqaQAlABsegIX25OiEmShi4oQ+lxnc5NQSO/lypXd5YZwOs5QQNggk6y1Z4
         3utqlvr5N9rwMXNt3vQkgAuAXH3kZKLbzR32vDRWqI3plbU+lZxiuZQNwDd+hklkBFNM
         Sj2qrikzkZPkPjWkJukruKeQRbPJs0kJ6WsCu2hFXPlN9IM6/wihFc0ZhkxJPf9JRVfZ
         psu/8qu0+FRkhabnNoPFCA27ey8JNrMLSZRHmot2CRLc1uho+L9D5wSravTWF92rOZEe
         H102UjsKxqewL06spXQgzzoALK0CmzTxLBNJJKk/wmXGMpWfqJzM3fSPpD9P/Hx2aeYU
         Ylpw==
X-Gm-Message-State: AOAM530KiWdEtG5m0BjhNA+PEzdFhWZFboyU2YYQxWOdqR0+uiHbStqP
        Fjk9OJ/0Lvpvc5u3Lle8HobB3TWfgx06Jlwc
X-Google-Smtp-Source: ABdhPJwmUOC6osdXBlkB/Qj0NsDB4aR41AiHXddPnzdRgQjncUYyow1HBMhCFCkR2Croja3zpZiSEA==
X-Received: by 2002:adf:8b45:: with SMTP id v5mr30322369wra.398.1618223490888;
        Mon, 12 Apr 2021 03:31:30 -0700 (PDT)
Received: from [192.168.3.162] (ip5b401b0e.dynamic.kabel-deutschland.de. [91.64.27.14])
        by smtp.gmail.com with ESMTPSA id l4sm13875886wrx.24.2021.04.12.03.31.30
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 03:31:30 -0700 (PDT)
From:   Benjamin Drung <benjamin.drung@ionos.com>
X-Google-Original-From: Benjamin Drung <benjamin.drung@cloud.ionos.com>
Message-ID: <8d930476e5daf34147a178420596230dfecf2038.camel@cloud.ionos.com>
Subject: rdma-core: Minimum supported Debian & Ubuntu releases
To:     linux-rdma@vger.kernel.org
Date:   Mon, 12 Apr 2021 12:31:26 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

which Debian & Ubuntu releases should rdma-core support? Do we have a
policy for that like all LTS versions?

-- 
Benjamin Drung

Senior DevOps Engineer and Debian & Ubuntu Developer
Compute Platform Operations

1&1 IONOS SE | Greifswalder Str. 207 | 10405 Berlin | Deutschland
E-Mail: benjamin.drung@ionos.com | Web: www.ionos.de

Hauptsitz Montabaur, Amtsgericht Montabaur, HRB 24498

Vorstand: Hüseyin Dogan, Dr. Martin Endreß, Claudia Frese, Henning
Kettler, Arthur Mai, Matthias Steinberg, Achim Weiß
Aufsichtsratsvorsitzender: Markus Kadelke


Member of United Internet

Diese E-Mail kann vertrauliche und/oder gesetzlich geschützte
Informationen enthalten. Wenn Sie nicht der bestimmungsgemäße Adressat
sind oder diese E-Mail irrtümlich erhalten haben, unterrichten Sie
bitte den Absender und vernichten Sie diese E-Mail. Anderen als dem
bestimmungsgemäßen Adressaten ist untersagt, diese E-Mail zu speichern,
weiterzuleiten oder ihren Inhalt auf welche Weise auch immer zu
verwenden.

This e-mail may contain confidential and/or privileged information. If
you are not the intended recipient of this e-mail, you are hereby
notified that saving, distribution or use of the content of this e-mail
in any way is prohibited. If you have received this e-mail in error,
please notify the sender and delete the e-mail.


