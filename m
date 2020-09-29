Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2485127D354
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 18:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgI2QJL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 12:09:11 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10109 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgI2QJK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Sep 2020 12:09:10 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f735bc10001>; Tue, 29 Sep 2020 09:07:29 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 16:09:09 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 29 Sep 2020 16:09:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+A8+xUnH60pU2UMj9gtU9RA22otQHIWOw5EDe5vdwNjV3qxfN/iK2wB8AgxyNFuaWT0wWd6YK9wYZ5EDXOENX6ye+QYjqmLDAXSl2uamGcd82UJujP/wq0VJEPexx/FyGHmPN9NamtZkIf7yItD31nPf/U0ThQKKWN9aixBXfoy7xvo09DwSzO1i2aOdTrwOrgPj8NVxeGtDPmQ+uoagIdkX7W9bzjL45zxKTaiFDhvhHqjC2CJIRzJPv9Fm/CbYdgLN0beYQ/oS7o0RyVrGOIISBJNv0Qx++m0hOzmcM2vqkNwzjPpPhOS9ZqosbZwKZCS/tLGmSe0jSNTgkMS2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Gjk5jp7MtVwjjo/hceVQYmrK0iOHINigCqEs3rU+kw=;
 b=Ld4fSWlAXsapGMwWWr7UOx4WrPB2PEH/RJSWHYMBKYKiDsC+kRQpLOelhDKJbM/GWxbitLCSrURa5gnIvreKAg66klJyWZ3oQ1Z1kBS2ULJLp8zZqghFLAhPUmfnDcfu/Gpu+SyuO61fqvGeXbz0cVsF0v3VKW/Nslcbltt9u+9f9EzCpEfi8GwkRUsJaxMBqJjB8MhmaoRiqADzdYeUbww+1YCBLHAV2AdrY2CAf71v6EWvsutBBSR+/Kz/dEU5KDDx/X/14Od4MiD1M0J83Bc0T5bYkAxbC3woSBEMqCPE+Kuu09jw/n0Xjv2/s3jzzD0rcoOkvRdObqOLIICAQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2437.namprd12.prod.outlook.com (2603:10b6:4:ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Tue, 29 Sep
 2020 16:09:08 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 16:09:08 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
Subject: [PATCH] RDMA/core: Remove ucontext->closing
Date:   Tue, 29 Sep 2020 13:09:07 -0300
Message-ID: <0-v1-df64ff042436+42-uctx_closing_jgg@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: MN2PR01CA0041.prod.exchangelabs.com (2603:10b6:208:23f::10)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR01CA0041.prod.exchangelabs.com (2603:10b6:208:23f::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23 via Frontend Transport; Tue, 29 Sep 2020 16:09:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kNIBf-00379G-JG     for linux-rdma@vger.kernel.org; Tue, 29 Sep 2020 13:09:07 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a8bfb2f-c535-4fdd-4afe-08d86491ff28
X-MS-TrafficTypeDiagnostic: DM5PR12MB2437:
X-Microsoft-Antispam-PRVS: <DM5PR12MB243731E58D84D93FC48205F3C2320@DM5PR12MB2437.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C7cNsUqEX8GYitEO/2FC7YcLiFNodjLuje+MokXucHMQ3Sn3A02kXddPdAqByv71XySeVBgdBfh7dO7X0dHtdwDAd7VmydWuNEyLNSBNI+65R13GCKrnDTZcdMiHvFTCq0E1pdiNmYjPseRSr1WqzN/G11DS1DRV1BtSpYJsJ9P14O9+ErChH71onXVYJwqBOcoaQOodwIbysRcxTGqOrHoHFfoY72Sr+4GWpT8XBJiabOb7D+wP8r2Rtk65tzeiRN9DxtmYPAnlz/QffS/rVmzYHjff5Oea7xtu9QxcJoXGkUvKTr2+1K0QV5F4+8m8L94beOItoMcv3CYiBTrfAWqH1Ezo/k2U0SaR+XfKfZcW5A8ZFwyQT4OYlQsa6ENIlw4TfzQYDcFD6fiFw+0t7ym/tT9JjYUzXwtGCR7i+Y8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(8936002)(26005)(2616005)(426003)(66946007)(5660300002)(6916009)(66556008)(9786002)(9746002)(36756003)(86362001)(186003)(66476007)(83380400001)(2906002)(478600001)(8676002)(316002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8zEXzDlCDK2QAMFfs6Cf7Lv9lYSj1/+Q5i7WYnPOlJ6WbQg/RAjpBg462x4hGSCk3eOghiA60R6JcgixrDlKt2VVeDHs0jsUSpfIFM/pcVgZsPMwYBeaZ8ssr0pYEIj+gxDTKOitmcx6+VNIm9gB2/KzF1KYYrkkniu4vs/xvWGNSEVyMN0qOAnYolkn7Q6oJ5pUSxOemvtbRAObk6y0AIfqFZqpdK2xjJUj+GCTpm1nELcgMvZea6OhtvXHiS7Kl0mb0p0VPHD9YhsUwpvoCDS6ryC5h9et1V96rprO8tZTR8I/FvRVH7boRMk0FbvixV0u50xQ1XCKoiAAqRSYA2/Rvc37GBm/PlOtrEvG6SSL7MOzOeVGLR34ILFXCCywxZe9s4h2xIF1ydxt008SOoDoYW56yJt5Q/IsgMkeQl3Ta0O1evBSM/7H5YW73dI4urChx/q9sUlhmt6cPMtjUeEEXC1QodJaOiAuECxYsc/tr9h37/3wsXNs3XidaCkHBQWLs9Wv4Rgc7X9voYeZXQzif1I31k7UkG/rky4od3xPF26q1Xsg7iq/NSh/ZHaQwb5yWiRm9sFOn1oJpO24VeNpH+fTMPnGPFtDjN5yMz9sz+m3C2GvZKp49lTSk1sw1NM06gn0/thuJCM618Sljg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8bfb2f-c535-4fdd-4afe-08d86491ff28
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 16:09:08.8670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvrw/5vqcJew0rWiuXip59UWtdBel6HB1LsIjKN4n70Hplfx6eObCSZGQj2SNmN2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2437
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601395649; bh=byeViUQODjCQmx/Mc6/a5xu1i8OMkJY976vTX1LDxe8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:From:To:Subject:Date:Message-ID:
         Content-Transfer-Encoding:Content-Type:X-Originating-IP:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=UoatRQ0NfwnPsjoFn6mB5Nfw3NG1iez2wa0RqzIDaX+cq1IbvOx8dDJN+EQOFvvOP
         7Fcqz+Nb/9JnYWLY+DxNkOKC55a0/77tYWq+aA66z8Jx5ozCAXkRkTf5EQW4+VZcbJ
         fGX1KZZx7FHlioCceY01VeNXycAF+/PybytRFoXWon7oe9skjfCYgWrCYhvbUKk3+4
         xjFD7DT92I1Z0VUsjqPuHCQCHRoksk4Viik8y+uKk082hEYvUhUM6FhmbKcIVqX3/x
         ePmszY4S0Nf7P2H6+WWfGGlKrwYVgxTZ/YEyE5BZ4g1QzPcS2ShBcHG9gxcZxo2zH+
         UsOYUmPfpFK4g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Nothing reads this any more, and the reason for its existance has passed
due to the deferred fput() scheme.

Fixes: 8ea1f989aa07 ("drivers/IB,usnic: reduce scope of mmap_sem")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/rdma_core.c | 1 -
 include/rdma/ib_verbs.h             | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/=
rdma_core.c
index d2b5417a4d5170..ffe11b03724cf5 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -889,7 +889,6 @@ void uverbs_destroy_ufile_hw(struct ib_uverbs_file *ufi=
le,
 	if (!ufile->ucontext)
 		goto done;
=20
-	ufile->ucontext->closing =3D true;
 	ufile->ucontext->cleanup_retryable =3D true;
 	while (!list_empty(&ufile->uobjects))
 		if (__uverbs_cleanup_ufile(ufile, reason)) {
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index f18502984e6f36..5ad997346f7fea 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1477,12 +1477,6 @@ struct ib_rdmacg_object {
 struct ib_ucontext {
 	struct ib_device       *device;
 	struct ib_uverbs_file  *ufile;
-	/*
-	 * 'closing' can be read by the driver only during a destroy callback,
-	 * it is set when we are closing the file descriptor and indicates
-	 * that mm_sem may be locked.
-	 */
-	bool closing;
=20
 	bool cleanup_retryable;
=20
--=20
2.28.0

