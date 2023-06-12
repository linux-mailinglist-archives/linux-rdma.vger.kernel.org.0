Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98C172CE87
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 20:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbjFLSfi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 14:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238253AbjFLSfO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 14:35:14 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75114113
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 11:35:08 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CIP92n031300;
        Mon, 12 Jun 2023 18:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=G7WGG0OnRrKk7021BHppIHPLTxfKwyhNv4XDqUTEis4=;
 b=Un4dJ2HTUXss+RIw6xFwUpHVtswdYfOLoKZJNzFQt4SxK6Sz7v163AitCQfXliCX17FO
 yW8YnDO0kxZqiLdVTJbxDHdxX5oB1w1kRev5tEOFmKKwKShOYMZFSRUHDvwoX+IJ4upY
 4mx7/w7OSW4yR57jg7kPzg/jYrbAL/ICuvboDMFz8uCA2A+mD7cYl4c5YN6BmiuApBwB
 Ekhuv01Safqm5dIpE1EN3kzSEGo55VHOzJt+7RsmO5/ttr8zhCD+W9B1rzgLyJiO93La
 GiP88HGF0bQRCYBPOiq4K/npMsswEWb0vR7Mic7sr6DxCw1LwHo6hyKmQSZlPXtcQ/sk WA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3r5ybdngdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 18:35:05 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id C3EF114786;
        Mon, 12 Jun 2023 18:35:04 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 12 Jun 2023 06:34:56 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 12 Jun 2023 06:34:56 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Mon, 12 Jun 2023 06:34:56 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 12 Jun 2023 06:34:56 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gy+XHcEccsGmkd/0JwcE6+ZzFSbWz7d/RDH3Vg8ukQMmEMmhJZyONUWZRXpJJBdTZc0DXE+sbTGssNG4wCPXaNnW+7rsW9SCIwNxSWXk9QiBs05yCNQ9yLFvo4F6yY/okUfMUQ5Pz5xrZCfikw4xXV09JALDbYBYD/aFxq7aus6BNFjgpzw6t4qfz3f7LWEaM2tj+G7C7ywinnwxgCaOUDoMv2iuZeCo5zba8n1LycdX8Mvifo9PhzMSUyRR/a0M2a/wW/ny2FYX9/2OpCw08REUh27C62U7JCVS8eZrGmsikWll1lK4foVaQuoZ9SUekTr2VDBKKRwZEiLlthiYvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7WGG0OnRrKk7021BHppIHPLTxfKwyhNv4XDqUTEis4=;
 b=PJUu4a2ChgWd2mqmnucNq8XON+gY4Mb6TYvp9Yqtbd6Qf7nGCHg/rhjhupzH2jliDNhZIljLVdIOV6HxNZ4BFKuHKQt7q4E5sVrUF3h2zq6tpt8MvziKEZo92Iiu0N8S0Tu0geAB9rF3H0TgVzgg/kdoSdiF086tFsBgAfOCd+DoTtmfnX+qFWnpmJHCZZMi3msl4qv838dYtfkDQ4vkPqjiw/tV3AOfmmw0TMx6ka7hlUWyzjqNtFhRHYrD9y+cBBIGCIbj0KhPrHGeJd3QpWhM6Pb8JRza7z7o2SWAjIR7qiiRGM9DclrTjAaxWAu4kDjKU33NFYAegNbsJDZFNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by SJ0PR84MB3285.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:432::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.40; Mon, 12 Jun
 2023 18:34:54 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ad7a:bf67:d9d0:371a]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ad7a:bf67:d9d0:371a%5]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 18:34:53 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next] RDMA/rxe: Fix rxe_cq_post
Thread-Topic: [PATCH for-next] RDMA/rxe: Fix rxe_cq_post
Thread-Index: AQHZnUXTxoUAZ6H9w0eTcnxE3USmha+HfKYAgAAB5YA=
Date:   Mon, 12 Jun 2023 18:34:53 +0000
Message-ID: <MW4PR84MB2307F2D9E6B38DF73EAC929DBC54A@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230612155032.17036-1-rpearsonhpe@gmail.com>
 <ZIdjqAVIjqHUEEnj@nvidia.com>
In-Reply-To: <ZIdjqAVIjqHUEEnj@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR84MB2307:EE_|SJ0PR84MB3285:EE_
x-ms-office365-filtering-correlation-id: 133da006-25b9-4521-a839-08db6b73b6db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kp7oT4GS0IHrfbITD6EX6hwHP3iPB+TN81c4kHNqGDhD+fE16GpeLYNCWK/sRKQuL+OQXmiYPSiPxTHrITtO+BR+rfE/kAWUd27uTWlQzm6GJq8MUd1fdQH37wvTcENLSfFBV2VYWJ0BXw3hWUXTBc0eMcIZ1gHCgCtXsoPlnz4e4KC9/GSbfFrX29OYPyRl2g7EYRwTTaZu45ikVUC27o9yZAwnHeGviKiGEiCqKtMuKIlQDnBUdHE1lnDW7WotcV0T3tGAcTzzsz6xHdPsrPd+nCSu/e6/OMTaX57tgekjsUiyxfuFHOezLvo76Gn249vqPA6uFQ1E6QM9sh2EI0XUVLl/lgJGg5cJ1hck2H0qI7YftMcm207mvJ7Z2ipQZ6842TTGFBOCteCitJazUSN/iU5IPFj39qUYy+6p93Foxm+kdAJl8vbTe+gHKKo+4Lt84Pz4388RUqOMSCI5JzYxLC2PDrcMT3uGYbHOPWj7hS3GPlHeHRhNb0f4yAm2YYG337XHPosNbPCxvVsgerV4NZj8s3Qz1Ew1l6CSuCNdELWVUAKVjKi1iiG8gM+S9tCw0cmToVxClZ2HULvmxLfXlikTz/PwdiGI2LHwawi3P2/yFS6VOo6/kxe7bl2E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(5660300002)(4326008)(64756008)(66476007)(52536014)(8936002)(41300700001)(76116006)(316002)(66556008)(66946007)(2906002)(54906003)(110136005)(8676002)(55236004)(53546011)(26005)(6506007)(9686003)(83380400001)(186003)(66446008)(38070700005)(82960400001)(122000001)(478600001)(7696005)(71200400001)(55016003)(86362001)(38100700002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qbMCpa1BFxxPB6ccqrHQGPT82QRU/ziyPllyH0PcnGgXRJ5nDOvsfybtKuKt?=
 =?us-ascii?Q?Eu8NvRAbZXSWKmi2KcV6DlzemwEy16IwcWAqseo5nOUu1No4tFLWsbtGCIqr?=
 =?us-ascii?Q?Jb8yJ/cSu5BRb9eP2kdT+bfi+0HPBS5glVr43gjps27T6fydFaFZTVqduQ8i?=
 =?us-ascii?Q?BFwiD5p+4wjARsw4e9vp/L44adhU0cKJa1GoJ7y0mcqNPUnwAherKEuEPjRY?=
 =?us-ascii?Q?Q0Cm8QBiPX108FU3it4WklyUvzC9WCVJadXnzqBqm/KHf5t2MyzIETlUGEwR?=
 =?us-ascii?Q?U8Fi9FH5L58mdHzrTQXfHHMB4HI/aVuMK3gOmVYHLax27WpgAwhtHztjlb4w?=
 =?us-ascii?Q?/4mRWO5s6T4K3JLijz+6O9XnqEXltglx7jgH8YwbAFtx/n0ifZhfSMxx5JXN?=
 =?us-ascii?Q?2kLgbbumFY4lPGuLj6CL3oChxaGi89oNxI7eL5qCNzfVVFMqK72Z3fZ1pPH3?=
 =?us-ascii?Q?rHgX8c3GeihJY6KNdit+eZtjQ6DQt7xRBe9GPe0ixqKxmHQIE1GHMJBbXOCE?=
 =?us-ascii?Q?m0XB2kPo5aeTTbRXUnJJJpP0XN6RYSkCLJvUuyJnvOVUcAqE/HBfo9jyUMmU?=
 =?us-ascii?Q?viieFry9Yxu7bc/QIn+1CLt2dFFocCj0DINu/4bp8ehXTiT+aCpdjSAl0o4f?=
 =?us-ascii?Q?Ol5y1WOQ3k/efhCsS4fHJ2ZQ3c6SGIYj2zqrEd3eVryJ7sgjF38Hb1ygyoYU?=
 =?us-ascii?Q?6Wdo8/nuOfW8oHQuFIGlUoxv1m9Mvksg5/2yML5fO9bD0zXWrbdpGIAeMDai?=
 =?us-ascii?Q?Vi/yUuu+HBKb4qJfWDUqzC6ULm6FlYb4OTsZRzy9uXYV24qoHjSJ9qjfWtej?=
 =?us-ascii?Q?sTfLUphVrmxUv8uBXWdBSdUeCaJPYv5qgnWmiDrv722pCuxs14KF0q6+WaSS?=
 =?us-ascii?Q?bgoZsheGPar6Xa1nrOZAzLUySrbkdFqA4ATNUdgCOIlCa3/J8qn0w0cS+nOX?=
 =?us-ascii?Q?W/jVbOsR5QmS52htckDzScwt+pt6gQWe4+BWtL0lELc+oasRbP3LOs3dh5mA?=
 =?us-ascii?Q?zUjpsoOfbKMLIhH2RhYBnq7GvDJfIzYaIQmGucGND2An4wa9zXw09BN0y2vM?=
 =?us-ascii?Q?NEKqnuyRGlTrTbzfEeLlLvpJWOFCdLLYSUMspI9EB5fJlNxhDx3Z/yzmWNnu?=
 =?us-ascii?Q?yD6zf5l7+Q5UwXBiTCDS0fea+LUqH1cxUPUrQsbo3Iw7rmjmren0bCX6NRuU?=
 =?us-ascii?Q?FQn4ajlE55eFPnrecDEMgfnF5wqMhksSIysXA7lWFh2CsknhQZKzCtl/NIK/?=
 =?us-ascii?Q?EV34bljrTBTG8LK0Ne0BYFhhDDAAOzbqz9Zga8uua+K7xYtyp06LxXOLv7l1?=
 =?us-ascii?Q?BXve0Wju0OxsX+Lr8tL7jsYZP+driPGMLgZeTWifPuPa2qWQVD09WLs0YVAN?=
 =?us-ascii?Q?UlJdlRSBaivsvQJ1DlblXoSOOrIfBdI/w0Ka5Jn/g8SgnWVjz0NmOnlOpIXW?=
 =?us-ascii?Q?XREyXyspHQEZVtBpqfmpB1ETgTyOMNblKyhuMSYcwgvKSwzM6bNbsCAi1js0?=
 =?us-ascii?Q?gnQleeiFiReZN4YbllsV+4kmCjntB9dVrpJsbUBp37rvrEoocCRkmJaYh8NB?=
 =?us-ascii?Q?ULJdEOGjkhU7UpULrteTZzP5CKBUB2zUl2XZiOCh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 133da006-25b9-4521-a839-08db6b73b6db
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 18:34:53.5952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UjOCI5kTyRn/k0pPA/lylroQ70JRg0p3M2LQvMpWDrtQQjfWymdN7CI6CmWV7ns8YR1Vws59ro3XaOYXxGOX5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB3285
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: BlTcTS4zLP3NP9zfOZmPWfi-H15K7nGW
X-Proofpoint-ORIG-GUID: BlTcTS4zLP3NP9zfOZmPWfi-H15K7nGW
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_13,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=754 clxscore=1015
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120160
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Jason, thanks. - Bob

-----Original Message-----
From: Jason Gunthorpe <jgg@nvidia.com>=20
Sent: Monday, June 12, 2023 1:28 PM
To: Bob Pearson <rpearsonhpe@gmail.com>
Cc: zyjzyj2000@gmail.com; linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Fix rxe_cq_post

On Mon, Jun 12, 2023 at 10:50:33AM -0500, Bob Pearson wrote:
> A recent patch replaced a tasklet execution of cq->comp_handler by a=20
> direct call. While this made sense it let changes to cq->notify state=20
> be unprotected and assumed that the cq completion machinery and the=20
> ulp done callbacks were reentrant. The result is that in some cases=20
> completion events can be lost. This patch moves the
> cq->comp_handler call inside of the spinlock in rxe_cq_post which
> solves both issues. This is compatible with the matching code in the=20
> request notify verb.
>=20
> Fixes: 78b26a335310 ("RDMA/rxe: Remove tasklet call from rxe_cq.c")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_cq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
