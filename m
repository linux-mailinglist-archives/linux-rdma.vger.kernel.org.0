Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95A6215F64
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 21:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgGFTc1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 15:32:27 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:57034 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725895AbgGFTc1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 15:32:27 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 066JU9oJ002842;
        Mon, 6 Jul 2020 12:32:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=03W4dVXa3/bxyow7QXnCAHZog7Z2K+uElQCCj6tOV7g=;
 b=UK/KSx/JryvsmclsAO2BZOmGwbaVUEXBXu5vlqz8PxzVapWrg1q+R9Rzcar8akrZjPBr
 gD+MkTzcq7E3VYeZK0i+KqznM2DS9QJGoSmCwuAM4rX3HaDZEAHTmCjx2km4paBsaAzl
 EcUx9YOez/DT7S5eOaYC3lOFgop+oYGsPQqXTolPMI79RmvjIkCXt2B77PEcg6svdRmx
 bggoMJ9afmSKoylCxfWmjcHA/1L7tJ0G7buwyTyIuNhWFxyHwHfDJu5+Ch3Jp9/Qg3yz
 OvfvF5j+yFsRrqqi7YZgd8bIOskjz7ns3R/hy6tt+QWU4mz6bDNBePtIhUiz8KoSxBQI nQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 322s9n7reu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 12:32:25 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 6 Jul
 2020 12:32:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 6 Jul 2020 12:32:23 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id BB5A93F703F;
        Mon,  6 Jul 2020 12:32:21 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <jgg@ziepe.ca>, <dledford@redhat.com>, <aelior@marvell.com>,
        <ybason@marvell.com>, <mkalderon@marvell.com>
CC:     <linux-rdma@vger.kernel.org>,
        Michal Kalderon <michal.kalderon@marvell.com>
Subject: [PATCH v2 rdma-next 0/2] RDMA/qedr: Add EDPM kernel-user flags for feature compatibility
Date:   Mon, 6 Jul 2020 22:32:12 +0300
Message-ID: <20200706193214.19942-1-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_19:2020-07-06,2020-07-06 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The two patches in this series are related to the EDPM feature.
EDPM is a hw feature for improving latency under certain conditions.

Related rdma-core pull request #786
https://github.com/linux-rdma/rdma-core/pull/786

Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>

Changes from v1
Add explicit padding to struct qedr_alloc_ucontext_resp in qedr-abi.h

Michal Kalderon (2):
  RDMA/qedr: Add EDPM mode type for user-fw compatibility
  RDMA/qedr: Add EDPM max size to alloc ucontext response

 drivers/infiniband/hw/qedr/qedr.h  |  1 +
 drivers/infiniband/hw/qedr/verbs.c | 20 ++++++++++++++------
 include/uapi/rdma/qedr-abi.h       | 10 +++++++---
 3 files changed, 22 insertions(+), 9 deletions(-)

-- 
2.14.5

