Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35352F18FC
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jan 2021 15:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbhAKO6j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jan 2021 09:58:39 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15014 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729688AbhAKO6i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Jan 2021 09:58:38 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffc67760000>; Mon, 11 Jan 2021 06:57:58 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 Jan
 2021 14:57:58 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 11 Jan 2021 14:57:55 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <jgg@nvidia.com>, <leonro@nvidia.com>, <sagi@grimberg.me>
CC:     <oren@nvidia.com>, <nitzanc@nvidia.com>, <sergeygo@nvidia.com>,
        <ngottlieb@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 0/4] IB/iser cleanups and fixes for 5.11
Date:   Mon, 11 Jan 2021 14:57:50 +0000
Message-ID: <20210111145754.56727-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610377078; bh=sDKfEVbGONAtWTQptc6I5tttb0J4vNxNEdLjwriCgnc=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         Content-Transfer-Encoding:Content-Type;
        b=XpUyXJmDn0uaJYJt/gkuYM43J/Li2S2YEgJlNpBpFiIPO1jfQ7ZsI1ZHuxp2TJXVu
         TuJjrK9X5/kIRlvFeMhIoMsPx2JBES2oC9qrn4r6fztmVt38pSMPdI+opewKrCaFYD
         KiyHBkCP2Vm1vo7ZPavLBMDh8qsX3HrY9LIqcNXaE1g7au2iluaEnTttJ9U1xC8XTF
         1IeeoEqNTkxMSPwWAYKStv8t26tdwXwnKo2LheqBY8SkdgZAIN+u/4VKTrFAE44Ks8
         IEpqj+xwPop4jHvTNLiqJHsNCjSgJApT7LVptBs9zYHMDyMnma7JlipB+FfirndZRv
         uDbpYuigowrLA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason/Leon/Sagi,
This series introduce some minor code conventions cleanups and 1 module
param fix that can cause the driver to fail in connection establishment
(if one will set max_sectors =3D 0).

Please consider this for the next 5.11 PR or for 5.12 merge window.

Max Gurtovoy (4):
  IB/iser: remove unneeded semicolons
  IB/iser: protect iscsi_max_lun module param using callback
  IB/iser: enforce iser_max_sectors to be greater than 0
  IB/iser: simplify prot_caps setting

 drivers/infiniband/ulp/iser/iscsi_iser.c  | 53 ++++++++++++++++-------
 drivers/infiniband/ulp/iser/iser_memory.c |  3 +-
 drivers/infiniband/ulp/iser/iser_verbs.c  |  2 +-
 3 files changed, 39 insertions(+), 19 deletions(-)

--=20
2.25.4

