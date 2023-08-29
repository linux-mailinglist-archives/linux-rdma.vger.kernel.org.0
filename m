Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CF078CA14
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Aug 2023 19:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbjH2RCa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Aug 2023 13:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237587AbjH2RCR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Aug 2023 13:02:17 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F2C107
        for <linux-rdma@vger.kernel.org>; Tue, 29 Aug 2023 10:02:14 -0700 (PDT)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 9BA563F56E
        for <linux-rdma@vger.kernel.org>; Tue, 29 Aug 2023 17:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1693328532;
        bh=rTEm+7dV2WDo9KaOCaCJkFVLY3l7Tp3juwn00ul0yfQ=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=dl8UUjx+UfR/RUYHzvnSPMGgoN5ffgL6Dh/n2T5xa7k8Q+0vOAOuHq40uR1tmkyyP
         MuWHeDIcVUYmDbLdZRxCAiLGnyrrMIOnwAcDOCE9yynReMNtakgsCUWTRx44/5fOGK
         YgBSU19rMORmcpNI5AoAMZLyRiuQyUJ1EIdS6s3J47JUtW/lU0IPGEbjxd4HYPP82D
         8x9nWGlXwgdoNCOPXPJ0gOocDrY8xJJtOxrkkNb+/DfZ0HyTXFF/ajUkETYzHFhsZG
         xY33TPq3xKwZ7L8MP+YySewA6iVuCYkWFnl7QEOKuepNivLbcgtQ68pH0J5Cm7sPMD
         /V45Mo+wygBpw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
        by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 698277E05F
        for <linux-rdma@vger.kernel.org>; Tue, 29 Aug 2023 17:02:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Message-Rationale: Requester @linux-rdma
X-Launchpad-Message-For: linux-rdma
X-Launchpad-Notification-Type: recipe-build-status
X-Launchpad-Archive: ~linux-rdma/ubuntu/rdma-core-daily
X-Launchpad-Build-State: MANUALDEPWAIT
To:     Linux RDMA <linux-rdma@vger.kernel.org>
From:   noreply@launchpad.net
Subject: [recipe build #3595821] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <169332853242.3695760.6843803282962752164.launchpad@buildd-manager.lp.internal>
Date:   Tue, 29 Aug 2023 17:02:12 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="1581722f568bb50ab87419582d337374517e2922"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 482e93aecd9db2b021122f9934b5d654b4f46ddd
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3595821/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-059

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3595821
Your team Linux RDMA is the requester of the build.

