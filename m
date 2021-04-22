Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DF2368334
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 17:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbhDVPUT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 11:20:19 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:37578 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236476AbhDVPUT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Apr 2021 11:20:19 -0400
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MF4Pxl015577;
        Thu, 22 Apr 2021 15:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=U1YM+4Jkw9CLXjuYskOhsxNokC5tV78gnD2qy7adNzc=;
 b=QFAJLo7veQGsOxpP7gxshoIwbuY3lhf3GejarFQ+Om0LLVhjQaVkU99lrCYeCpf8Azwo
 LgBUHLsPgILD80D/y7lcdLokA9OP1YmziQZ1BfusLb7FHrWppE0Sb5lxqdUR2Q2fW/e3
 98Il+nOU8CODXT0tq97nbqhswtoSG4ZEwOZu0XRiN7bJIqNhSHP1p9ZDmp85dmvpm7FQ
 3HHFFDzAxgcg+wgyGUsgh0RFyX+zRIon/ZwGq03NZDpqlhoiV/M8q4r3rbTMfejcPw85
 7TtminRKSoWYA7JrLjLAWP17f5r43RpHhtM4SrqsfMLEgWNTOrdtA22juEqEcam8xae/ Hg== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0a-002e3701.pphosted.com with ESMTP id 3833664msg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 15:19:40 +0000
Received: from G1W8108.americas.hpqcorp.net (g1w8108.austin.hp.com [16.193.72.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3427.houston.hpe.com (Postfix) with ESMTPS id C572C89;
        Thu, 22 Apr 2021 15:19:39 +0000 (UTC)
Received: from G9W8454.americas.hpqcorp.net (2002:10d8:a104::10d8:a104) by
 G1W8108.americas.hpqcorp.net (2002:10c1:483c::10c1:483c) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 22 Apr 2021 15:19:27 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (15.241.52.10) by
 G9W8454.americas.hpqcorp.net (16.216.161.4) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 22 Apr 2021 15:19:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JG0k84yDjlzcy0xcprSTl6g3eju2JQxemiahFNmR6VsbV3WQBgJze36Y1WGotkBzW+xTa1A8cxmua7Kmcz/HaR4HZczfIyHwybIS6CdzvA6Z19HLqhRcr0ssZaCmdxaLnm5s79l4Mn3mtwRORlIsgArnNSCXQYoLW60owuZ5gD1hC0WYgewzdmmUFlNyNi++JCA3OW+S9hrWdt7r2znqiI329oOeJdhCY3jCZbNvjqL0CPPbn2AIY+EpBON4cPkqy/HR5fDr8IrqUoDlHfag8bYdYlgUbc1u/Nzsb94OUtptpdjJiVG8nIvgb0UcnW3c7M3ScNXabiDEUsEakcM8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCkeJxCK0VlTUGu0/+sMxnaugX8jQZVeqqFamxtiV5o=;
 b=kVRCS98bE/alMCFKaX/Q3S2VC3m5tNJUl2fXjXxgq8bJP0L1FUBN9W/4qasvQD/QRX1D8s2WCcpoNvBVvIshoC1ijXojQi0QtbstLg/k73Mg84OBFsPXJu1BFO7+vu+L4mfobHz2wFi6ABJA1BCpsvychNdN5Ay1pjhQORKoosJ0zSqUIO3Ijd0K4Dn4EJjOnnAfVUOHrRmaKejsXRBG1JujHqfJrf64E5AGu+mRQmxfgMr+zOdO9XYmqjUyArtu/sSkunluX2ChuJp1QlCw+vOwJ+YxYVLy6dh5T0VwoElf//kq9UfCDd3lH0JTP7auSdvN2BNl+1M/+xAldYGOCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DF4PR8401MB1098.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7612::13) by DF4PR8401MB0812.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:760d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.23; Thu, 22 Apr
 2021 15:19:25 +0000
Received: from DF4PR8401MB1098.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::b1ef:7366:4eab:e8fd]) by DF4PR8401MB1098.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::b1ef:7366:4eab:e8fd%3]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 15:19:25 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "kbuild@lists.01.org" <kbuild@lists.01.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "lkp@intel.com" <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>
Subject: RE: [kbuild] Re: [PATCH for-next v4 10/10] RDMA/rxe: Disallow MR
 dereg and invalidate when bound
Thread-Topic: [kbuild] Re: [PATCH for-next v4 10/10] RDMA/rxe: Disallow MR
 dereg and invalidate when bound
Thread-Index: AQHXNzhlFcJEUNOQsUqM6X8QHW94zqrAWdKAgABNMbA=
Date:   Thu, 22 Apr 2021 15:19:25 +0000
Message-ID: <DF4PR8401MB109892562BB8736E29D501B4BC469@DF4PR8401MB1098.NAMPRD84.PROD.OUTLOOK.COM>
References: <20210422052822.36527-11-rpearson@hpe.com>
 <20210422104203.GN1959@kadam>
In-Reply-To: <20210422104203.GN1959@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [2603:8081:140c:1a00:2551:616d:a720:3397]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a1e63e7-23ef-4649-4277-08d905a203a7
x-ms-traffictypediagnostic: DF4PR8401MB0812:
x-microsoft-antispam-prvs: <DF4PR8401MB08121A08D68AAA4C83EA316CBC469@DF4PR8401MB0812.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:181;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NDtc/ILVP4jzD6prvvv+cAu8S4eN6AbRyha3J/xvyaNTei/YaQ9W1ebftrgEw5v6wfNjxhEVkTrYlMq/4LxSU6F4CVeOnobCLrROvjCPsqNVgCp1WL6ZG/Q2ZoB0Z6JaGN54ngQu3FVlPGR6N9TdCPCFwHl47s1uaYuk926NvjLo/4kK/me390h/RYZKpOIrPXaqn4wSt3OtdeEu8wvRtpcvFrudd8weUYNct/gbYHcjTTupMEsCf6c+4Z9R0/ef0vmoAaYc2hLv4qKZPVfji2bYCKhezTwn7vFO1mxwEIS1IWmCtmmYh8Z/qDh6p8NNGibG7I2UlZrV0IHE1dQwKkt1AletKCT6IkN5DdPn6xW1Su72a4SVlkmelYwxx8XBNcHdsGKoHV30aub33H4Mf9mPxlzpv/mjAVUbPRux9tSl+VJ8jB8t93NgsIpRmOzwqHGxF645/wAiy6AaChqRWsfMhNzzRUVNeKbDxWVf5DUYJMSIHbAWz+ropNoKplj8MtFJOkogFSA+AtEdKXwiT/OKlKrEWYSirn+8NTxH9FcdwIeq9g/o/GPHUTpomJigjAtDnoyVqcjGDB3K2824vBchhpWrKzr3wKxfDNMVHQk4vqe9Schfp3ayJvjR+OanoTSILcz3vMUIssFkcEK2efki8SWVLDLO6hnLBYps85YA4ohQbP6BX7QAqSSNK+XN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DF4PR8401MB1098.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(376002)(366004)(66476007)(66446008)(66946007)(316002)(64756008)(66556008)(8936002)(54906003)(76116006)(7696005)(2906002)(9686003)(55016002)(5660300002)(52536014)(83380400001)(478600001)(53546011)(186003)(6506007)(966005)(86362001)(122000001)(38100700002)(4326008)(110136005)(71200400001)(33656002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Zk24Xajcme5sIpjpBWl3+SgHXCRHqM7m6U7Ofu/3vH9M15jwrBsvju4mrEsY?=
 =?us-ascii?Q?koFb2BTX6ToDzAkfEqXuGyb6ZanLKEbborrxOSgw9b/JO4xWYaZblu+TuRbX?=
 =?us-ascii?Q?FoJDUxXUq1yl+EnZECXRruLRLp4GhLo2IIS8FWwwqUW8k82vWL4zLJfskAEZ?=
 =?us-ascii?Q?wdj55f1JhijSsWMWP2BIgrhptQMI1fAUalK5jtp75Z4Re6K0Xg8n1S39lg+R?=
 =?us-ascii?Q?fSVRwXXBSkf3zyUamTLGQKh5wbb91R4maRWExgfLm0fht5bEladMa3n5tFZb?=
 =?us-ascii?Q?4o7JljmMEF4ymh3+akcj5t/YCgFT6CNQMmDzMtk7ANY29WieWSucB3ikyCQv?=
 =?us-ascii?Q?5oyCniAMAEsg6Ezs/vvXUnsbJP65aWkdCHcn6lDWD7il/ubB09VObIaCFoED?=
 =?us-ascii?Q?MRqnIW7+rO26x7+q8+EYwBXQc1fE+u27z0d75u3ywUnZ4ZJr0UrV3Rosdybj?=
 =?us-ascii?Q?yPAWPauTZYyDn1myCNkyiXF2siu/rpHMjZCmoRUDiWVyTarTLprhbVaRwBdT?=
 =?us-ascii?Q?e8GkQiVR2xStoAFhRa1NuKq523kESgJfn5fva2ZoXEJ5Fq8krD5T6j3YCc5J?=
 =?us-ascii?Q?H2OBzu8ELOWN00/Do7VQoGju592pH3VbjE7/jv2MaIF05RL2Fx5ad+8V5pQU?=
 =?us-ascii?Q?2B4D7LurVKOhV9fvoGM3YG71CMUSWPxkjbRKigEcHXcn2DedujgDxjaPu3c6?=
 =?us-ascii?Q?FG4tINWChBivyCqPjnNroB/To6ISevRm10fqJxwd+cC3SCE1DB8skBeMJalD?=
 =?us-ascii?Q?4UFFSBrf/3Jzpb1JAB0e5rMpxaXmjVYvcan0B99JWsBygWNg9yUTcaIKJnpT?=
 =?us-ascii?Q?v41d8SNZ/6gJEszb4OkWg1qDScmJqa8/y1O2ErjI5UMnJfcJ0XD5FlV6xd+r?=
 =?us-ascii?Q?HGbRQujqzuXg9Fo9FD1Om8FYOOVgLuWhPmwTzUdM8Kw4ENnHsItv5jBb8Z6j?=
 =?us-ascii?Q?tozbK+32FQUZ3Bh87M19gbVH74HrTm1wWqT6gnahnVIvg4nkOY/iDMj5wQsP?=
 =?us-ascii?Q?KtIXFlj+J7jYjzbHvonEeSk04yWM/KSS5Q/rqYMXA3dYYvlm0d7UiQYt09gc?=
 =?us-ascii?Q?MpL+7LMDbA3BJOryWueHP33weYhRj08c0qVgD0SJFY3aSBMHI/Keuc/I/0+r?=
 =?us-ascii?Q?CScuxxIhc6wBTCgRUjhimD8/C4jJu9ZYA3WhDtBzOPw7+ZpqWr6RZnT7oJyG?=
 =?us-ascii?Q?slPTn0yS+ONowsI5Vb/Yq5rq8e3vVDDZUQBWIteCIoG2FKvrmTD1X6o0T3Mn?=
 =?us-ascii?Q?xOulV7ZapEg5IRSwTWQHdHujrraIo10bE0GSsrm4ctPp0LF9E2LSe/XX/u8k?=
 =?us-ascii?Q?mliIYUmrv6FPPafrfvtURuxHB2b/N5n1PLtL4QCdj2SK3lFnKhF/o1cwmV52?=
 =?us-ascii?Q?o/ZdqgDMjBlDTLbm/+nhEqp1nflQ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DF4PR8401MB1098.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1e63e7-23ef-4649-4277-08d905a203a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 15:19:25.2080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c42q9+MXVUjQzS6fDa2oQ6r9swdNTQFIfO5m50np2HFLcY5BU7PpJvXiV1KwW38+03LiFygRMR6m0gVY/xJMiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB0812
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: KWQt1GTpehT19WHHb9yg14jPwdTJ-q8G
X-Proofpoint-ORIG-GUID: KWQt1GTpehT19WHHb9yg14jPwdTJ-q8G
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_06:2021-04-22,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220120
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

That's the problem with coding in the middle of the night. Thanks. Bob

-----Original Message-----
From: Dan Carpenter <dan.carpenter@oracle.com>=20
Sent: Thursday, April 22, 2021 5:42 AM
To: kbuild@lists.01.org; Bob Pearson <rpearsonhpe@gmail.com>; jgg@nvidia.co=
m; zyjzyj2000@gmail.com; linux-rdma@vger.kernel.org
Cc: lkp@intel.com; kbuild-all@lists.01.org; Pearson, Robert B <robert.pears=
on2@hpe.com>
Subject: [kbuild] Re: [PATCH for-next v4 10/10] RDMA/rxe: Disallow MR dereg=
 and invalidate when bound

Hi Bob,

url:    https://github.com/0day-ci/linux/commits/Bob-Pearson/RDMA-rxe-Imple=
ment-memory-windows/20210422-132958
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-=
next
config: x86_64-randconfig-m001-20210421 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/infiniband/sw/rxe/rxe_mr.c:553 rxe_invalidate_mr() warn: ignoring u=
nreachable code.

vim +553 drivers/infiniband/sw/rxe/rxe_mr.c

5f1e7f44d3a9cdb Bob Pearson 2021-04-22  529  int rxe_invalidate_mr(struct r=
xe_qp *qp, u32 rkey) 5f1e7f44d3a9cdb Bob Pearson 2021-04-22  530  {
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  531  	struct rxe_dev *rxe =3D to_rd=
ev(qp->ibqp.device);
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  532  	struct rxe_mr *mr;
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  533  	int ret;
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  534=20=20
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  535  	mr =3D rxe_pool_get_index(&rx=
e->mr_pool, rkey >> 8);
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  536  	if (!mr) {
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  537  		pr_err("%s: No MR for rkey %=
#x\n", __func__, rkey);
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  538  		ret =3D -EINVAL;
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  539  		goto err;
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  540  	}
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  541=20=20
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  542  	if (rkey !=3D mr->ibmr.rkey) {
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  543  		pr_err("%s: rkey (%#x) doesn=
't match mr->ibmr.rkey (%#x)\n",
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  544  			__func__, rkey, mr->ibmr.rk=
ey);
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  545  		ret =3D -EINVAL;
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  546  		goto err_drop_ref;
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  547  	}
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  548=20=20
740526f943e87ee Bob Pearson 2021-04-22  549  	if (atomic_read(&mr->num_mw) =
> 0) {
740526f943e87ee Bob Pearson 2021-04-22  550  		pr_warn("%s: Attempt to inva=
lidate an MR while bound to MWs\n",
740526f943e87ee Bob Pearson 2021-04-22  551  				__func__);
740526f943e87ee Bob Pearson 2021-04-22  552  		return -EINVAL;
740526f943e87ee Bob Pearson 2021-04-22 @553  		goto err_drop_ref;

Either the goto or the return should be deleted.  I would have expected tha=
t it would be the return to be deleted, otherwise it needs a big comment wh=
y we're holding on to the reference.

740526f943e87ee Bob Pearson 2021-04-22  554  	}
740526f943e87ee Bob Pearson 2021-04-22  555=20=20
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  556  	mr->state =3D RXE_MR_STATE_FR=
EE;
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  557  	ret =3D 0;
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  558 5f1e7f44d3a9cdb Bob Pearson 202=
1-04-22  559  err_drop_ref:
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  560  	rxe_drop_ref(mr);
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  561  err:
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  562  	return ret;
5f1e7f44d3a9cdb Bob Pearson 2021-04-22  563  }

---
0-DAY CI Kernel Test Service, Intel Corporation https://lists.01.org/hyperk=
itty/list/kbuild-all@lists.01.org=20
