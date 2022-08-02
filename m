Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9415883C1
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Aug 2022 23:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiHBVsN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Aug 2022 17:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiHBVsL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Aug 2022 17:48:11 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5907A25C79
        for <linux-rdma@vger.kernel.org>; Tue,  2 Aug 2022 14:48:09 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272L8Kvk001731;
        Tue, 2 Aug 2022 21:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=DR+Cj8HBZCdujnsQ/+2Rtxjm6tu1CIec4NZsswWn7sQ=;
 b=kMEforwTd3SKkQ2iwnCyPIFMs1Zl/cAb9rGxqu2tBPShn7ARmAiDgu9N5U13mxsf7nIQ
 sbOcrpxn0B9pl0JuDN04KmXpaD5gKogqRjO0czGQRdyKz1oe1FtgTWyEjtcBROrst1AU
 MVbEIQjWNGx7KBbvwzOXyXZT/v7sIxjxDNeVPCqAKC9HxCfojeFIxyrisD7VTVatUB0J
 pSpZx3RaR/nVIC8FyE8MsojlSqsmyUacbkktQOhPPcGgI4l1OuAYZVI8fvlhJM+khSXD
 4Wgix6eLDN/7JhJ9lToz39Dmgh+PlMFSih88vHQ6ePfPtktK/PZX8EfgNbZZAWFHZUHq 2g== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hqbjh07c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 21:48:04 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 52DFCD2CE;
        Tue,  2 Aug 2022 21:48:03 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 2 Aug 2022 09:47:46 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 2 Aug 2022 09:47:46 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 2 Aug 2022 09:32:00 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqxEpg8V9++lpw2pqrlXdqT0tytBIOaT2vwVof8UO1u16f8M6gmGUaSQCnYHWf1q77slTvGLhXF/GGYrqav4MZC7ZMyeFAVfU59O/QYgQ3RD/t0oGCgyeewoObTQI4OWMD++LYXxiEWsVF8eJD2NhpKnKv2xajwjt0nnzcAtgMJW/yEMDP4Mq6hduaVZe3/IZInsBVspjy0FlwLUu4KDD9wI6BCRo2IqPbyrVmVibScvuNgcRtNxkeQv3JWQ8T8cfo6RKsftDvdrDF28Z8yN1/Vc4yjo6SQCNT00YXW5Ts+JJ6HNzJI2Jt4XqMPNoBggPXGsbIipYD5B7DPjnR1v2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DR+Cj8HBZCdujnsQ/+2Rtxjm6tu1CIec4NZsswWn7sQ=;
 b=WiluK8lyPCMOmpwDCdz3ZIAEfkfPxj92m06uViXInh7lDKOjURAUhX5dOIAmXVN1FozjAKpb+dDIVJf6xJKkn/SQEASdYrKJIPELNViqLaw7fLnI+UuS8fvjW2k+dAga3Eq46t8qtkggKwt29MpxA2kIvd52WoilLUYSxvdUoERtz2cjggO8XNpA6c8TZxWrDje5ujkDDTpip2lY1rxhbx4ZCj/N7z9H1G0xkkeRrCqdmK578IUItgl5xYOVlCm5bk+pNCvnMQzVfrajh/pL/tMS1cRy6eHAYD98mPz0rMoRIAKZ7yW3xdV2dhoX4VhaOvXiG0N5DqgXRwk6JciNxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by MN0PR84MB3118.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:208:3c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Tue, 2 Aug
 2022 21:31:51 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4ce9:c60a:8e9:34a]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4ce9:c60a:8e9:34a%5]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 21:31:51 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "Hack, Jenny (Ft. Collins)" <jhack@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next] RDMA/rxe: Guard mr state against race conditions
Thread-Topic: [PATCH for-next] RDMA/rxe: Guard mr state against race
 conditions
Thread-Index: AQHYprbqtr1/QAmjhUaWUrF7q1YUK62cIPhw
Date:   Tue, 2 Aug 2022 21:31:51 +0000
Message-ID: <MW4PR84MB2307FED79C726D8C8AA1FAD7BC9D9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220802212731.2313-1-rpearsonhpe@gmail.com>
In-Reply-To: <20220802212731.2313-1-rpearsonhpe@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f53146eb-9cf8-4fe3-e258-08da74ce69b7
x-ms-traffictypediagnostic: MN0PR84MB3118:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yZBCVzwkgfUScPYJxmGXMX7tUYxdoRnWq3oyT3mFVVi9Jcbrp2760SnIcuTkTP9ucEW2zD7c5VPK/lJ9oQXtox6FQhNWyzlZKLcCXVWzB8sgA1ST8DAH/zyCmubfGibDgG20dbuTZtIHv9EIt6hFnI59mxmAnLTYdfxMNCWGurTaIWdLhOOtpS3UbjRrGn+S7PvrYpe+3dAeoxv9P8IoARzbrf7VN9zbwauocTforPF+NzKImqsrx2JOpJWVsiFPYpkGO9wcSeaafFI3pjoJQAN90G98EVr4opNr1kBsy6wX6Jt7WAQijhEIjhoRMTyY1vS8FoBZT1pubzYSX7uD8ZwH4pA6emDXcO5nJIqyryR0B2E6xvDgGrsa56s3QPK6R/mAWIJCSXg4sCUX4tEpab/Q+4Dn+t3HVwGa2YGz8VlaO/YWGT94EpFpZbCiyIqzsy+O5z+9IDGxzmcMj0HMKrzT9Uazx/HjG/ragljJEY1CHYPLQOvoSxGodPh/uGOirUN9ZUtlRx+Ui776HnwEzq2D5MCDMVeY7v9u6R2RhrUIpZuF2JSf+TF5W0i76K+5ePvcS5kcHW3/eo7gA3CbF/n10S5IqzwkC+UrE7Sh3CEZQ5BpWr2px0+u+rWCe1eAbFqyeaN0VxUUXPeb6zTv9yFb6q8ox48BfR2LLwhbP5f6MXKlub7JmpNgPn5b/+aR9X49QOHxB4jDJd08cjGKxgOBE+Nadty0z68k4zK/5El2MRbBLL/MyEj+7wov9pzPOFGqKM74vskD1kVzBBDTfog61Y481URSjIAeIg9prfYSPaPNGml/LZT1enz896zy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(39860400002)(136003)(346002)(396003)(55016003)(82960400001)(110136005)(26005)(186003)(316002)(9686003)(30864003)(2906002)(52536014)(478600001)(41300700001)(122000001)(83380400001)(7696005)(6506007)(8936002)(53546011)(66556008)(86362001)(64756008)(66446008)(33656002)(8676002)(66946007)(38100700002)(76116006)(5660300002)(38070700005)(71200400001)(66476007)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2kR20N+39+OQ5E8v8uXp/yDBKObHll2NISZmj6SqjvNrmtgTEJ5gQD5oHCoR?=
 =?us-ascii?Q?F6jrweDqLrCJSFS7S9sm0diu/awstjaH30ic3PosTPyzYbYBmQiG1bUCsHxj?=
 =?us-ascii?Q?K++Y0P4hbXdkzwvmWQApjj3Sy28pFe16fb2vS2nnDUMXK9YFFcYdcglVB1JB?=
 =?us-ascii?Q?joiLlcj7dGSf8pTPuh6mDmgcqVghZGt/7k/oyKXg/7nQNsNurBNNBEo02V/k?=
 =?us-ascii?Q?2XDBJjQbd3bmEL3xW2c0vlXQ5SLCMaPXF6lZ2qKfG8CsASY7ABfCF2hSR4QX?=
 =?us-ascii?Q?vXBLNYdQXj+YgFbLNikaNrgh4wo1bbvn7vR4ne+bdCT260Rhujz+9BEHXirT?=
 =?us-ascii?Q?rjq8ehaHaJH+AQJx56/GMZGd1sBI1U/ADzP9k/90XhaOTCF6Tnyp1uTekAqJ?=
 =?us-ascii?Q?B6Rxtq/VW/aKhEVh/yB33hD9UIV6MO+lzSR5M9q4V4eileFigFdmdivkoEqW?=
 =?us-ascii?Q?XpphK2JKojdciqURzrgsl7OzhPHMyMiTxv63QggQhFi0B52St5Q6eQl8YEJ1?=
 =?us-ascii?Q?vBbI2s+DWuOdxYXDPc1s8B47Oz9dskx2n4si1KL4ANIeCDDfnmWKOawLzT4h?=
 =?us-ascii?Q?MlgInZKxDE8ixZj9f3Xf/Ex88TlOntjO5kAMt0gDeg+dJapecp6qeplHMMsv?=
 =?us-ascii?Q?5KeoImJoazFV2C7Nas1L8fHalyHtFPTv/hS6EyvFS5x2SIBr8VApXwTH6iqf?=
 =?us-ascii?Q?DWXNi5eEk7OsscrUqX3IaONTOsZvASoTsLtSvdPP41NWcGKlkVaQt3691WLQ?=
 =?us-ascii?Q?eHGGCb4WL3chT1A9F5qp5sGJvrwWvsLKfUNWlHz4ae/z4ham2i3Gy+vuZXRC?=
 =?us-ascii?Q?h0H/mRrxt7RMwJKTEznnEBgnJll122ZcjUwJrontaQw6FibQRJ89vJQo3q3N?=
 =?us-ascii?Q?tZ5UMp2vzmAEOa6ykJt+qbDKRe2AsRZtso+yV6OWCSqt8r0MEn0csrwlq78H?=
 =?us-ascii?Q?UhwoY4G1RPX+Gnp4Vmen6PAEIYhkLkVQsEYpGdFWO07ryzZBiokB2ieLseA+?=
 =?us-ascii?Q?ffK9oC4l0hQR1/Ax5Yem4VT908FRBOMNUOqU0RvJL/bvMGcDunxCX11eMxnu?=
 =?us-ascii?Q?rNhHmsaKjWDV7+TP8yNxINwxCj3pQ5Lceg29fzYgYPunOLUJsMPDwy0RLiMI?=
 =?us-ascii?Q?DLGP2qKEirWFN1XHI6h/HBjZDJTppnpg4YjGmjF4GJh6mKB2YrfhofW4olDG?=
 =?us-ascii?Q?eWI4oU0d07vasXDGjdno6BYA3iYr/4rlFuxDIuO/bcQfBYj7iaemM6alLCWH?=
 =?us-ascii?Q?M1WGBzis2ZBvXK72hWD6gL5DLfo/GvIuAY81dLdVyfk01Qu+406rZO5wsgqM?=
 =?us-ascii?Q?WyfujuUROcjADTDT+CNMfT4Q8brNzJduSQbd3ZYAwCYSQ7nbBLcTIeFyO0p1?=
 =?us-ascii?Q?pfoZLEX5dBKzYxQPmVegltctsSvhkH4aXHBCili6yztaukGKBXq/tXvBG65q?=
 =?us-ascii?Q?NCc9Whkf7bA2SMp29yfSDVcNKAd97N6oSloM0D7Lcep8WmL9qoSDdllBJ9OY?=
 =?us-ascii?Q?QcNpyy3SdcmjNzFL5IXD9r1aXENINKwY5vFyuBNfbTrNN9laVgku9J5xyk1P?=
 =?us-ascii?Q?aaIuiPX2B3ts9ZyIRvdR4YRLggrBRC2JYlLCZUcL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f53146eb-9cf8-4fe3-e258-08da74ce69b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 21:31:51.1621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2MCHUDt07sfO66riXelrQWvZm9zEcPGcxNTg1KYv+9fm6lXjNB/6rhxk1fntAq3HUQzZkp5rFZUk6oG3z0fApw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR84MB3118
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: T5qW_5aKw0ypV4N3ezlXoix8TVZ4dH1d
X-Proofpoint-ORIG-GUID: T5qW_5aKw0ypV4N3ezlXoix8TVZ4dH1d
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_14,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 mlxlogscore=909 suspectscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208020101
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Should make this 'PATCH v2 for-next'

-----Original Message-----
From: Bob Pearson <rpearsonhpe@gmail.com>=20
Sent: Tuesday, August 2, 2022 4:28 PM
To: jgg@nvidia.com; zyjzyj2000@gmail.com; lizhijian@fujitsu.com; Hack, Jenn=
y (Ft. Collins) <jhack@hpe.com>; linux-rdma@vger.kernel.org
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Guard mr state against race conditions

Currently the rxe driver does not guard changes to the mr state against rac=
e conditions which can arise from races between local operations and remote=
 invalidate operations. This patch adds a spinlock to the mr object and mak=
es these state changes atomic. It also introduces parameters to count the n=
umber of active dma transfers and indicate that an invalidate operation is =
pending.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2
  Addressed issues raised by Jason Gunthorpe regarding preventing
  access to memory after a local or remote invalidate operation
  is carried out. The patch was updated to busy wait the invalidate
  operation until recent memcpy operations complete while blocking
  additional dma operations from starting.
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |   6 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    | 149 +++++++++++++------
 drivers/infiniband/sw/rxe/rxe_req.c   |   8 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  | 200 ++++++++++++--------------  dr=
ivers/infiniband/sw/rxe/rxe_verbs.h |  10 +-
 5 files changed, 204 insertions(+), 169 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rx=
e/rxe_loc.h
index 22f6cc31d1d6..e643950d58e8 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -73,8 +73,8 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, =
int length,  int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_in=
fo *dma,
 	      void *addr, int length, enum rxe_mr_copy_dir dir);  void *iova_to_v=
addr(struct rxe_mr *mr, u64 iova, int length); -struct rxe_mr *lookup_mr(st=
ruct rxe_pd *pd, int access, u32 key,
-			 enum rxe_mr_lookup_type type);
+struct rxe_mr *rxe_get_mr(struct rxe_pd *pd, int access, u32 key); void=20
+rxe_put_mr(struct rxe_mr *mr);
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);  int advan=
ce_dma_data(struct rxe_dma_info *dma, unsigned int length);  int rxe_invali=
date_mr(struct rxe_qp *qp, u32 key); @@ -90,6 +90,8 @@ int rxe_invalidate_m=
w(struct rxe_qp *qp, u32 rkey);  struct rxe_mw *rxe_lookup_mw(struct rxe_qp=
 *qp, int access, u32 rkey);  void rxe_mw_cleanup(struct rxe_pool_elem *ele=
m);
=20
+int rxe_invalidate_rkey(struct rxe_qp *qp, u32 rkey);
+
 /* rxe_net.c */
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 				int paylen, struct rxe_pkt_info *pkt); diff --git a/drivers/infiniband=
/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 850b80f5ad8b..bf318c9da851 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -61,7 +61,8 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
 	mr->lkey =3D mr->ibmr.lkey =3D lkey;
 	mr->rkey =3D mr->ibmr.rkey =3D rkey;
=20
-	mr->state =3D RXE_MR_STATE_INVALID;
+	spin_lock_init(&mr->lock);
+
 	mr->map_shift =3D ilog2(RXE_BUF_PER_MAP);  }
=20
@@ -109,7 +110,7 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int access, str=
uct rxe_mr *mr)
=20
 	mr->ibmr.pd =3D &pd->ibpd;
 	mr->access =3D access;
-	mr->state =3D RXE_MR_STATE_VALID;
+	smp_store_release(&mr->state, RXE_MR_STATE_VALID);
 	mr->type =3D IB_MR_TYPE_DMA;
 }
=20
@@ -182,7 +183,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 =
length, u64 iova,
 	mr->iova =3D iova;
 	mr->va =3D start;
 	mr->offset =3D ib_umem_offset(umem);
-	mr->state =3D RXE_MR_STATE_VALID;
+	smp_store_release(&mr->state, RXE_MR_STATE_VALID);
 	mr->type =3D IB_MR_TYPE_USER;
=20
 	return 0;
@@ -210,7 +211,7 @@ int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, =
struct rxe_mr *mr)
=20
 	mr->ibmr.pd =3D &pd->ibpd;
 	mr->max_buf =3D max_pages;
-	mr->state =3D RXE_MR_STATE_FREE;
+	smp_store_release(&mr->state, RXE_MR_STATE_FREE);
 	mr->type =3D IB_MR_TYPE_MEM_REG;
=20
 	return 0;
@@ -255,18 +256,22 @@ static void lookup_iova(struct rxe_mr *mr, u64 iova, =
int *m_out, int *n_out,
 	}
 }
=20
+/**
+ * iova_to_vaddr - convert IO virtual address to kernel address
+ * @mr:
+ * @iova:
+ * @length:
+ *
+ * Context: should be called while mr is in the VALID state
+ *
+ * Returns: on success returns kernel address else NULL on error  */
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)  {
 	size_t offset;
 	int m, n;
 	void *addr;
=20
-	if (mr->state !=3D RXE_MR_STATE_VALID) {
-		pr_warn("mr not in valid state\n");
-		addr =3D NULL;
-		goto out;
-	}
-
 	if (!mr->map) {
 		addr =3D (void *)(uintptr_t)iova;
 		goto out;
@@ -397,7 +402,7 @@ int copy_data(
 	}
=20
 	if (sge->length && (offset < sge->length)) {
-		mr =3D lookup_mr(pd, access, sge->lkey, RXE_LOOKUP_LOCAL);
+		mr =3D rxe_get_mr(pd, access, sge->lkey);
 		if (!mr) {
 			err =3D -EINVAL;
 			goto err1;
@@ -409,7 +414,7 @@ int copy_data(
=20
 		if (offset >=3D sge->length) {
 			if (mr) {
-				rxe_put(mr);
+				rxe_put_mr(mr);
 				mr =3D NULL;
 			}
 			sge++;
@@ -422,8 +427,7 @@ int copy_data(
 			}
=20
 			if (sge->length) {
-				mr =3D lookup_mr(pd, access, sge->lkey,
-					       RXE_LOOKUP_LOCAL);
+				mr =3D rxe_get_mr(pd, access, sge->lkey);
 				if (!mr) {
 					err =3D -EINVAL;
 					goto err1;
@@ -454,13 +458,13 @@ int copy_data(
 	dma->resid	=3D resid;
=20
 	if (mr)
-		rxe_put(mr);
+		rxe_put_mr(mr);
=20
 	return 0;
=20
 err2:
 	if (mr)
-		rxe_put(mr);
+		rxe_put_mr(mr);
 err1:
 	return err;
 }
@@ -498,34 +502,67 @@ int advance_dma_data(struct rxe_dma_info *dma, unsign=
ed int length)
 	return 0;
 }
=20
-/* (1) find the mr corresponding to lkey/rkey
- *     depending on lookup_type
- * (2) verify that the (qp) pd matches the mr pd
- * (3) verify that the mr can support the requested access
- * (4) verify that mr state is valid
+/**
+ * rxe_get_mr - lookup an mr from pd, access and key
+ * @pd: the pd
+ * @access: access requirements
+ * @key: lkey or rkey
+ *
+ * Takes a reference to mr
+ *
+ * Returns: on success return mr else NULL
  */
-struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
-			 enum rxe_mr_lookup_type type)
+struct rxe_mr *rxe_get_mr(struct rxe_pd *pd, int access, u32 key)
 {
 	struct rxe_mr *mr;
 	struct rxe_dev *rxe =3D to_rdev(pd->ibpd.device);
 	int index =3D key >> 8;
+	int remote =3D access & IB_ACCESS_REMOTE;
=20
 	mr =3D rxe_pool_get_index(&rxe->mr_pool, index);
 	if (!mr)
 		return NULL;
=20
-	if (unlikely((type =3D=3D RXE_LOOKUP_LOCAL && mr->lkey !=3D key) ||
-		     (type =3D=3D RXE_LOOKUP_REMOTE && mr->rkey !=3D key) ||
-		     mr_pd(mr) !=3D pd || (access && !(access & mr->access)) ||
-		     mr->state !=3D RXE_MR_STATE_VALID)) {
+	spin_lock_bh(&mr->lock);
+	if ((remote && mr->rkey !=3D key) ||
+	    (!remote && mr->lkey !=3D key) ||
+	    (mr_pd(mr) !=3D pd) ||
+	    (access && !(access & mr->access)) ||
+	    (mr->state !=3D RXE_MR_STATE_VALID)) {
+		spin_unlock_bh(&mr->lock);
 		rxe_put(mr);
-		mr =3D NULL;
+		return NULL;
 	}
+	mr->num_dma++;
+	spin_unlock_bh(&mr->lock);
=20
 	return mr;
 }
=20
+/**
+ * rxe_put_mr - drop a reference to mr with an active DMA
+ * @mr: the mr
+ *
+ * Undo the effects of rxe_get_mr().
+ */
+void rxe_put_mr(struct rxe_mr *mr)
+{
+	if (!mr)
+		return;
+
+	spin_lock_bh(&mr->lock);
+	if (mr->num_dma > 0) {
+		mr->num_dma--;
+		if (mr->invalidate && !mr->num_dma) {
+			mr->invalidate =3D 0;
+			mr->state =3D RXE_MR_STATE_FREE;
+		}
+	}
+	spin_unlock_bh(&mr->lock);
+
+	rxe_put(mr);
+}
+
 int rxe_invalidate_mr(struct rxe_qp *qp, u32 key)  {
 	struct rxe_dev *rxe =3D to_rdev(qp->ibqp.device); @@ -534,32 +571,46 @@ i=
nt rxe_invalidate_mr(struct rxe_qp *qp, u32 key)
=20
 	mr =3D rxe_pool_get_index(&rxe->mr_pool, key >> 8);
 	if (!mr) {
-		pr_err("%s: No MR for key %#x\n", __func__, key);
+		pr_debug("%s: No MR for key %#x\n", __func__, key);
 		ret =3D -EINVAL;
 		goto err;
 	}
=20
 	if (mr->rkey ? (key !=3D mr->rkey) : (key !=3D mr->lkey)) {
-		pr_err("%s: wr key (%#x) doesn't match mr key (%#x)\n",
+		pr_debug("%s: wr key (%#x) doesn't match mr key (%#x)\n",
 			__func__, key, (mr->rkey ? mr->rkey : mr->lkey));
 		ret =3D -EINVAL;
 		goto err_drop_ref;
 	}
=20
 	if (atomic_read(&mr->num_mw) > 0) {
-		pr_warn("%s: Attempt to invalidate an MR while bound to MWs\n",
+		pr_debug("%s: Attempt to invalidate an MR while bound to MWs\n",
 			__func__);
 		ret =3D -EINVAL;
 		goto err_drop_ref;
 	}
=20
 	if (unlikely(mr->type !=3D IB_MR_TYPE_MEM_REG)) {
-		pr_warn("%s: mr->type (%d) is wrong type\n", __func__, mr->type);
+		pr_debug("%s: mr->type (%d) is wrong type\n", __func__, mr->type);
 		ret =3D -EINVAL;
 		goto err_drop_ref;
 	}
=20
-	mr->state =3D RXE_MR_STATE_FREE;
+	spin_lock_bh(&mr->lock);
+	if (mr->state =3D=3D RXE_MR_STATE_INVALID) {
+		spin_unlock_bh(&mr->lock);
+		ret =3D -EINVAL;
+		goto err_drop_ref;
+	} else if (mr->num_dma > 0) {
+		spin_unlock_bh(&mr->lock);
+		mr->invalidate =3D 1;
+		ret =3D -EAGAIN;
+		goto err_drop_ref;
+	} else {
+		mr->state =3D RXE_MR_STATE_FREE;
+	}
+	spin_unlock_bh(&mr->lock);
+
 	ret =3D 0;
=20
 err_drop_ref:
@@ -581,32 +632,32 @@ int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_sen=
d_wqe *wqe)
 	u32 key =3D wqe->wr.wr.reg.key;
 	u32 access =3D wqe->wr.wr.reg.access;
=20
-	/* user can only register MR in free state */
-	if (unlikely(mr->state !=3D RXE_MR_STATE_FREE)) {
-		pr_warn("%s: mr->lkey =3D 0x%x not free\n",
-			__func__, mr->lkey);
-		return -EINVAL;
-	}
-
 	/* user can only register mr with qp in same protection domain */
 	if (unlikely(qp->ibqp.pd !=3D mr->ibmr.pd)) {
-		pr_warn("%s: qp->pd and mr->pd don't match\n",
+		pr_debug("%s: qp->pd and mr->pd don't match\n",
 			__func__);
 		return -EINVAL;
 	}
=20
 	/* user is only allowed to change key portion of l/rkey */
 	if (unlikely((mr->lkey & ~0xff) !=3D (key & ~0xff))) {
-		pr_warn("%s: key =3D 0x%x has wrong index mr->lkey =3D 0x%x\n",
+		pr_debug("%s: key =3D 0x%x has wrong index mr->lkey =3D 0x%x\n",
 			__func__, key, mr->lkey);
 		return -EINVAL;
 	}
=20
-	mr->access =3D access;
-	mr->lkey =3D key;
-	mr->rkey =3D (access & IB_ACCESS_REMOTE) ? key : 0;
-	mr->iova =3D wqe->wr.wr.reg.mr->iova;
-	mr->state =3D RXE_MR_STATE_VALID;
+	spin_lock_bh(&mr->lock);
+	if (mr->state =3D=3D RXE_MR_STATE_FREE) {
+		mr->access =3D access;
+		mr->lkey =3D key;
+		mr->rkey =3D (access & IB_ACCESS_REMOTE) ? key : 0;
+		mr->iova =3D wqe->wr.wr.reg.mr->iova;
+		mr->state =3D RXE_MR_STATE_VALID;
+	} else {
+		spin_unlock_bh(&mr->lock);
+		return -EINVAL;
+	}
+	spin_unlock_bh(&mr->lock);
=20
 	return 0;
 }
@@ -619,6 +670,10 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *=
udata)
 	if (atomic_read(&mr->num_mw) > 0)
 		return -EINVAL;
=20
+	spin_lock_bh(&mr->lock);
+	mr->state =3D RXE_MR_STATE_INVALID;
+	spin_unlock_bh(&mr->lock);
+
 	rxe_cleanup(mr);
=20
 	return 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rx=
e/rxe_req.c
index 49e8f54db6f5..9a9ee2a3011c 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -570,11 +570,7 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct =
rxe_send_wqe *wqe)
 	switch (opcode) {
 	case IB_WR_LOCAL_INV:
 		rkey =3D wqe->wr.ex.invalidate_rkey;
-		if (rkey_is_mw(rkey))
-			ret =3D rxe_invalidate_mw(qp, rkey);
-		else
-			ret =3D rxe_invalidate_mr(qp, rkey);
-
+		ret =3D rxe_invalidate_rkey(qp, rkey);
 		if (unlikely(ret)) {
 			wqe->status =3D IB_WC_LOC_QP_OP_ERR;
 			return ret;
@@ -671,7 +667,7 @@ int rxe_requester(void *arg)
=20
 	if (wqe->mask & WR_LOCAL_OP_MASK) {
 		err =3D rxe_do_local_ops(qp, wqe);
-		if (unlikely(err))
+		if (err)
 			goto err;
 		else
 			goto done;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/r=
xe/rxe_resp.c
index b36ec5c4d5e0..6c10f9759ae9 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -314,7 +314,7 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
 	/* don't trust user space data */
 	if (unlikely(wqe->dma.num_sge > srq->rq.max_sge)) {
 		spin_unlock_irqrestore(&srq->rq.consumer_lock, flags);
-		pr_warn("%s: invalid num_sge in SRQ entry\n", __func__);
+		pr_debug("%s: invalid num_sge in SRQ entry\n", __func__);
 		return RESPST_ERR_MALFORMED_WQE;
 	}
 	size =3D sizeof(*wqe) + wqe->dma.num_sge*sizeof(struct rxe_sge); @@ -402,=
6 +402,54 @@ static enum resp_states check_length(struct rxe_qp *qp,
 	}
 }
=20
+static struct rxe_mr *rxe_rkey_to_mr(struct rxe_qp *qp, int access, u32=20
+rkey) {
+	struct rxe_mw *mw;
+	struct rxe_mr *mr;
+
+	if (rkey_is_mw(rkey)) {
+		mw =3D rxe_lookup_mw(qp, access, rkey);
+		if (!mw)
+			return NULL;
+
+		if (mw->access & IB_ZERO_BASED)
+			qp->resp.offset =3D mw->addr;
+
+		mr =3D mw->mr;
+		if (!mr) {
+			rxe_put(mw);
+			return NULL;
+		}
+
+		spin_lock_bh(&mr->lock);
+		if (mr->state =3D=3D RXE_MR_STATE_VALID) {
+			mr->num_dma++;
+			rxe_get(mr);
+		} else {
+			spin_unlock_bh(&mr->lock);
+			rxe_put(mw);
+			return NULL;
+		}
+		spin_unlock_bh(&mr->lock);
+
+		rxe_put(mw);
+	} else {
+		mr =3D rxe_get_mr(qp->pd, access, rkey);
+		if (!mr)
+			return NULL;
+	}
+
+	return mr;
+}
+
+/**
+ * check_rkey - validate rdma parameters for packet
+ * @qp: the qp
+ * @pkt: packet info for the current request packet
+ *
+ * Returns: next state in responder state machine
+ *	    RESPST_EXECUTE on success else an error state
+ */
 static enum resp_states check_rkey(struct rxe_qp *qp,
 				   struct rxe_pkt_info *pkt)
 {
@@ -415,6 +463,11 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	enum resp_states state;
 	int access;
=20
+	/*
+	 * Parse the reth header or atmeth header if present
+	 * to extract the rkey, iova and length. Else use the
+	 * updated parameters from the previous packet.
+	 */
 	if (pkt->mask & RXE_READ_OR_WRITE_MASK) {
 		if (pkt->mask & RXE_RETH_MASK) {
 			qp->resp.va =3D reth_va(pkt);
@@ -438,46 +491,20 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	/* A zero-byte op is not required to set an addr or rkey. */
 	if ((pkt->mask & RXE_READ_OR_WRITE_MASK) &&
 	    (pkt->mask & RXE_RETH_MASK) &&
-	    reth_len(pkt) =3D=3D 0) {
+	    reth_len(pkt) =3D=3D 0)
 		return RESPST_EXECUTE;
-	}
=20
 	va	=3D qp->resp.va;
 	rkey	=3D qp->resp.rkey;
 	resid	=3D qp->resp.resid;
 	pktlen	=3D payload_size(pkt);
=20
-	if (rkey_is_mw(rkey)) {
-		mw =3D rxe_lookup_mw(qp, access, rkey);
-		if (!mw) {
-			pr_debug("%s: no MW matches rkey %#x\n",
-					__func__, rkey);
-			state =3D RESPST_ERR_RKEY_VIOLATION;
-			goto err;
-		}
-
-		mr =3D mw->mr;
-		if (!mr) {
-			pr_err("%s: MW doesn't have an MR\n", __func__);
-			state =3D RESPST_ERR_RKEY_VIOLATION;
-			goto err;
-		}
-
-		if (mw->access & IB_ZERO_BASED)
-			qp->resp.offset =3D mw->addr;
-
-		rxe_put(mw);
-		rxe_get(mr);
-	} else {
-		mr =3D lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
-		if (!mr) {
-			pr_debug("%s: no MR matches rkey %#x\n",
-					__func__, rkey);
-			state =3D RESPST_ERR_RKEY_VIOLATION;
-			goto err;
-		}
-	}
+	/* get mr from rkey */
+	mr =3D rxe_rkey_to_mr(qp, access, rkey);
+	if (!mr)
+		return RESPST_ERR_RKEY_VIOLATION;
=20
+	/* check that dma fits into mr */
 	if (mr_check_range(mr, va + qp->resp.offset, resid)) {
 		state =3D RESPST_ERR_RKEY_VIOLATION;
 		goto err;
@@ -511,7 +538,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
=20
 err:
 	if (mr)
-		rxe_put(mr);
+		rxe_put_mr(mr);
 	if (mw)
 		rxe_put(mw);
=20
@@ -536,8 +563,8 @@ static enum resp_states write_data_in(struct rxe_qp *qp=
,
 				      struct rxe_pkt_info *pkt)
 {
 	enum resp_states rc =3D RESPST_NONE;
-	int	err;
 	int data_len =3D payload_size(pkt);
+	int err;
=20
 	err =3D rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
 			  payload_addr(pkt), data_len, RXE_TO_MR_OBJ); @@ -610,11 +637,6 @@ sta=
tic enum resp_states atomic_reply(struct rxe_qp *qp,
 	}
=20
 	if (!res->replay) {
-		if (mr->state !=3D RXE_MR_STATE_VALID) {
-			ret =3D RESPST_ERR_RKEY_VIOLATION;
-			goto out;
-		}
-
 		vaddr =3D iova_to_vaddr(mr, qp->resp.va + qp->resp.offset,
 					sizeof(u64));
=20
@@ -701,59 +723,6 @@ static struct sk_buff *prepare_ack_packet(struct rxe_q=
p *qp,
 	return skb;
 }
=20
-/**
- * rxe_recheck_mr - revalidate MR from rkey and get a reference
- * @qp: the qp
- * @rkey: the rkey
- *
- * This code allows the MR to be invalidated or deregistered or
- * the MW if one was used to be invalidated or deallocated.
- * It is assumed that the access permissions if originally good
- * are OK and the mappings to be unchanged.
- *
- * TODO: If someone reregisters an MR to change its size or
- * access permissions during the processing of an RDMA read
- * we should kill the responder resource and complete the
- * operation with an error.
- *
- * Return: mr on success else NULL
- */
-static struct rxe_mr *rxe_recheck_mr(struct rxe_qp *qp, u32 rkey) -{
-	struct rxe_dev *rxe =3D to_rdev(qp->ibqp.device);
-	struct rxe_mr *mr;
-	struct rxe_mw *mw;
-
-	if (rkey_is_mw(rkey)) {
-		mw =3D rxe_pool_get_index(&rxe->mw_pool, rkey >> 8);
-		if (!mw)
-			return NULL;
-
-		mr =3D mw->mr;
-		if (mw->rkey !=3D rkey || mw->state !=3D RXE_MW_STATE_VALID ||
-		    !mr || mr->state !=3D RXE_MR_STATE_VALID) {
-			rxe_put(mw);
-			return NULL;
-		}
-
-		rxe_get(mr);
-		rxe_put(mw);
-
-		return mr;
-	}
-
-	mr =3D rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
-	if (!mr)
-		return NULL;
-
-	if (mr->rkey !=3D rkey || mr->state !=3D RXE_MR_STATE_VALID) {
-		rxe_put(mr);
-		return NULL;
-	}
-
-	return mr;
-}
-
 /* RDMA read response. If res is not NULL, then we have a current RDMA req=
uest
  * being processed or replayed.
  */
@@ -769,6 +738,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	int err;
 	struct resp_res *res =3D qp->resp.res;
 	struct rxe_mr *mr;
+	int access =3D IB_ACCESS_REMOTE_READ;
=20
 	if (!res) {
 		res =3D rxe_prepare_res(qp, req_pkt, RXE_READ_MASK); @@ -780,7 +750,7 @@=
 static enum resp_states read_reply(struct rxe_qp *qp,
 			mr =3D qp->resp.mr;
 			qp->resp.mr =3D NULL;
 		} else {
-			mr =3D rxe_recheck_mr(qp, res->read.rkey);
+			mr =3D rxe_rkey_to_mr(qp, access, res->read.rkey);
 			if (!mr)
 				return RESPST_ERR_RKEY_VIOLATION;
 		}
@@ -790,7 +760,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		else
 			opcode =3D IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST;
 	} else {
-		mr =3D rxe_recheck_mr(qp, res->read.rkey);
+		mr =3D rxe_rkey_to_mr(qp, access, res->read.rkey);
 		if (!mr)
 			return RESPST_ERR_RKEY_VIOLATION;
=20
@@ -812,9 +782,10 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	err =3D rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
 			  payload, RXE_FROM_MR_OBJ);
 	if (err)
-		pr_err("Failed copying memory\n");
+		pr_debug("Failed copying memory\n");
+
 	if (mr)
-		rxe_put(mr);
+		rxe_put_mr(mr);
=20
 	if (bth_pad(&ack_pkt)) {
 		u8 *pad =3D payload_addr(&ack_pkt) + payload; @@ -824,7 +795,7 @@ static=
 enum resp_states read_reply(struct rxe_qp *qp,
=20
 	err =3D rxe_xmit_packet(qp, &ack_pkt, skb);
 	if (err) {
-		pr_err("Failed sending RDMA reply.\n");
+		pr_debug("Failed sending RDMA reply.\n");
 		return RESPST_ERR_RNR;
 	}
=20
@@ -846,16 +817,27 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	return state;
 }
=20
-static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
+int rxe_invalidate_rkey(struct rxe_qp *qp, u32 rkey)
 {
-	if (rkey_is_mw(rkey))
-		return rxe_invalidate_mw(qp, rkey);
-	else
-		return rxe_invalidate_mr(qp, rkey);
+	int count =3D 100;
+	int err;
+
+	do {
+		if (rkey_is_mw(rkey))
+			err =3D rxe_invalidate_mw(qp, rkey);
+		else
+			err =3D rxe_invalidate_mr(qp, rkey);
+		udelay(1);
+	} while(err =3D=3D -EAGAIN && count--);
+
+	WARN_ON(!count);
+
+	return err;
 }
=20
-/* Executes a new request. A retried request never reach that function (se=
nd
- * and writes are discarded, and reads and atomics are retried elsewhere.
+/* Executes a new request packet. A retried request never reaches this
+ * function (send and writes are discarded, and reads and atomics are
+ * retried elsewhere.)
  */
 static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pk=
t)  { @@ -900,7 +882,7 @@ static enum resp_states execute(struct rxe_qp *qp=
, struct rxe_pkt_info *pkt)
 	if (pkt->mask & RXE_IETH_MASK) {
 		u32 rkey =3D ieth_rkey(pkt);
=20
-		err =3D invalidate_rkey(qp, rkey);
+		err =3D rxe_invalidate_rkey(qp, rkey);
 		if (err)
 			return RESPST_ERR_INVALIDATE_RKEY;
 	}
@@ -1043,7 +1025,7 @@ static int send_ack(struct rxe_qp *qp, u8 syndrome, u=
32 psn)
=20
 	err =3D rxe_xmit_packet(qp, &ack_pkt, skb);
 	if (err)
-		pr_err_ratelimited("Failed sending ack\n");
+		pr_debug("Failed sending ack\n");
=20
 err1:
 	return err;
@@ -1064,7 +1046,7 @@ static int send_atomic_ack(struct rxe_qp *qp, u8 synd=
rome, u32 psn)
=20
 	err =3D rxe_xmit_packet(qp, &ack_pkt, skb);
 	if (err)
-		pr_err_ratelimited("Failed sending atomic ack\n");
+		pr_debug("Failed sending atomic ack\n");
=20
 	/* have to clear this since it is used to trigger
 	 * long read replies
@@ -1103,7 +1085,7 @@ static enum resp_states cleanup(struct rxe_qp *qp,
 	}
=20
 	if (qp->resp.mr) {
-		rxe_put(qp->resp.mr);
+		rxe_put_mr(qp->resp.mr);
 		qp->resp.mr =3D NULL;
 	}
=20
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/=
rxe/rxe_verbs.h
index a24fbe984066..77ac6308997c 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -271,11 +271,6 @@ enum rxe_mr_copy_dir {
 	RXE_FROM_MR_OBJ,
 };
=20
-enum rxe_mr_lookup_type {
-	RXE_LOOKUP_LOCAL,
-	RXE_LOOKUP_REMOTE,
-};
-
 #define RXE_BUF_PER_MAP		(PAGE_SIZE / sizeof(struct rxe_phys_buf))
=20
 struct rxe_phys_buf {
@@ -302,7 +297,12 @@ struct rxe_mr {
=20
 	u32			lkey;
 	u32			rkey;
+
 	enum rxe_mr_state	state;
+	int			invalidate;
+	int			num_dma;
+	spinlock_t		lock;	/* guard state */
+
 	enum ib_mr_type		type;
 	u64			va;
 	u64			iova;
--
2.34.1

