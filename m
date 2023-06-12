Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1049672C5E4
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 15:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbjFLN1i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 09:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbjFLN1g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 09:27:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E21FB
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 06:27:32 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CBx0EB031899;
        Mon, 12 Jun 2023 13:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nah5u/axCM+ySuqsj20fxepwBdp2/AfM+SYo+4m4iKk=;
 b=mqSx/461U089MgoFXhcYlOg4GlXFah2EyabiHprVEgHEk8K2o9kTyXEkLiLFe9bXGQDh
 fgcDoUSqDrHniVUa4SYqGDY7TXLVfdsf3BjyDbbEH48dZUOVFTICd030K25FiHe+OnsX
 k9zMoFKPA0Zb01Bso1QOfrVAdx492/EVHXteQ2mgq0VcYSbMqbZy8SfeIRcxHWJNALCF
 8Qh3sVfoEyejzfa6pSI/7Ydv5y9zHnP23aPbJCLeoNaP7TU/5D9Hh0tQZzIuimBO2TTE
 LaB4ZzZ5kTKS9uoKLnivrywNkq5knlN22HXGqmGcJ3Wx7Kev4/Sr3w5nZkdm2frN2eov Bw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fkdjvwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 13:27:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CBTFkJ008328;
        Mon, 12 Jun 2023 13:27:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm915af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 13:27:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SO68SUY5KEDCnAcLpjaGl+RUGKnuRLZLo9YIZ2ZeDiiNyjcNtCpk7iAH8WQQ6ot2gioE3YttAdMeiWq/BVTAK0+9FkjQqlHbnJg4PQqJzVcDcOLdtrG5gg/NxRDCav6eVm52kUorNwgLQBcZ3W9SBvbJe8ojwc6sVQypNdb86pJd8pfPbpc8mYtVK8XABJjdYP6a+MaMW0OehwutLvBwHko3GuBi/a+M06VqfmfXeys98qTRDcW5wKL/SYh/SjiVKcJ4VMXCa4qyjNcxYJoRnezVQNnjvXY4OTxmd8MP83KGvCrSFs6bCIZLlzMLq6n1Ui2+Vu9lwIDY0Yb57KZ2fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nah5u/axCM+ySuqsj20fxepwBdp2/AfM+SYo+4m4iKk=;
 b=ALqcUPXXiSyQLVt39yUmfeL5gdo+Nu7MIDBJpqnrKOD3qkK7+Gc22fNrf6mz5Sv1wsrWElTGsEhyRyrALxd2+rF0pE4KQie7FCI6oFoeAXBpDxHu6f2oyzj4ea2wFTLyj19AAE+SgnaVFygjNM8Q42rNrYXxfSpppGgUKViB6TMNOFU1iwUsMNKSXJYTD4a6XsBm744Izzbexc3w4MC2Z3b/XzO5oeu0LCGPHYQfukejRtsKSsp1ox3/svMCNgv152vA0ZACIlpBai0aEP/P2BHXJOy+OLOR3qqHEaiol9BWfuUEjCY/y4WqGervU0JyBFd+dJm4v5PJkJMAVA5quw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nah5u/axCM+ySuqsj20fxepwBdp2/AfM+SYo+4m4iKk=;
 b=uGo8jR50bnPhhPqNjs6uCqDrWJHUuR4/4mDsKC8ZJqcDkKY4p/zpWxRAXIPyoiKs6uH9jC9gHg/j/DnM5ZP4YEzS7cy1rgK7flT8hhrTMj4zwh3xmuc0NnCOQuTMmLwGu2ILTRdUdgpKHccesQafOL77h930gYa+kekf4JtP/oc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6125.namprd10.prod.outlook.com (2603:10b6:8:c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Mon, 12 Jun
 2023 13:27:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 13:27:23 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Chuck Lever <cel@kernel.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/cma: Address sparse warnings
Thread-Topic: [PATCH] RDMA/cma: Address sparse warnings
Thread-Index: AQHZmkTaE246fsT+50iLhtYRyzyux6+F6rgAgABvzACAAFoiAIAAegEA
Date:   Mon, 12 Jun 2023 13:27:23 +0000
Message-ID: <3E4B9E99-4B2F-40B7-8B14-D0A18FC01B4D@oracle.com>
References: <168625482324.6564.3866640282297592339.stgit@oracle-102.nfsv4bat.org>
 <20230611180748.GI12152@unreal>
 <64058A51-B935-4027-B00B-E83428E25BFB@oracle.com>
 <20230612061032.GL12152@unreal>
In-Reply-To: <20230612061032.GL12152@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB6125:EE_
x-ms-office365-filtering-correlation-id: 6cac6e76-5f55-4ac6-d16d-08db6b48c1d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bwJqiv39We/fs147JMfKsrsX6KbYA6XTUek6fK1zFtFGELcGx9uNadc8wJJAa1XpKOgRmdYAWmqrX1u8F34Ab2miuBiwG+fCF8z4/ZubsM+rzF2GfuyTkryYo2nBQ45gsZgtZbelkdmdVx/Z8Fxi0tgMnYEvkmg878upXic8xdcWPJLwWhg9DY7rEpwXr3Z/6jz3NV6WECmHFuCOSdGfsXlrI0YAfc2ia5cymk7dDOtqg4zbJxu/UEoNbt9SqZqE/JDOJPnoQYjMq1gVKzyvmT/dseE2kDxoEXSMmRepAPK9V/f7x/P6y6Tm+QPvcnJvysixaleowhBaf2w6vTyQOg1n87tdq+p7a4MEuiBuC52JRj/3zj6Tu2P4K6VGlT7GsaOtBL81rVUY/wS9KWvoXiRIX27BThT++vwDMR3onsCKiQGmAtIa4VPZP+SQa28HBEd9U2WRlkxI7A9dwCgGR+tqkVAfj0/yQltCdFCmhBaSb2siNKAkrOlSw7szh9U69czoGB7z+K1oKDVPtmseCglMMt+ORObgx1rSZabwK/2dANpwfKi1qEwQ/FbJ+nbJ9WQzZvM8kua8vPOcUDA+oJqIUXdsZLBV2ucP+w7KD/z6C9oHO3MUuU13IjhdsQrQpm+DpY0iGAC+UNy5swvn9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(54906003)(36756003)(2906002)(38070700005)(71200400001)(86362001)(91956017)(478600001)(33656002)(5660300002)(8676002)(8936002)(66476007)(6916009)(66946007)(76116006)(4326008)(66446008)(66556008)(64756008)(122000001)(38100700002)(316002)(41300700001)(83380400001)(2616005)(6512007)(6506007)(53546011)(26005)(186003)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sPOLde6H+UUhe0XkRY0x7bDU/FTjGMk2FXiH+7mtMN26fSDT4mms3/jTCkiQ?=
 =?us-ascii?Q?W5EpxOMn2i73VUjIh4ZIV5qEhA6tBGxJuc1A45Zy053QHzMv6ZKSi9nKRhyg?=
 =?us-ascii?Q?YMT5HcDSnRJXCAYh/QMkTYtQBedvWtbROZbb1+yiR/r7wG1/zfUMOvDGcC0j?=
 =?us-ascii?Q?ox4JC6TaazVTfMcSZDi7AEdYCRRh1FzjjY8xg4ecaLkzzV/nZUlJ1ciZDTxq?=
 =?us-ascii?Q?i1Thg5GV2sTBVGu+crNwq3JVlD11sprls5mtvoSXiTbIHNJvbuEXCJaebwfE?=
 =?us-ascii?Q?ZKmlnywJlASA19DA9SClMx7shQ1G/4KVKIq+iLvVumPWIoirL8aiT0uksjo+?=
 =?us-ascii?Q?PzbkuT+tatqlT4e+eayp4X63Cp+yybS5Ai6WMWVyYawK7uFboPULYSiT0VvF?=
 =?us-ascii?Q?tY20ptzO/qicEUn3uBYWd9Ogvvf1fUwRrhsAKfIOwQ8Ufd5lIpGkmfMe2Dsv?=
 =?us-ascii?Q?DPt9uGVRciO1tKIoV0N4JKWiRb2vLkPb+7DE3QheZ6L3SXTbG0jrLEui8jb6?=
 =?us-ascii?Q?TQL78cTgFpLSo2nEmgwBghvqKxVkoOEMDUS1YLuvTbEnetXvThREpYQCLtQo?=
 =?us-ascii?Q?mFNKbrkWp4EUmnK5VhH2h6QfJ9/IJz4CrD8hcMhe0CFiZ9hK1IYXMbbkkpCt?=
 =?us-ascii?Q?dlkAonLn++PEuen9kvt+4P1NtJmqy8xQeFN7otT3+TkfVCEPLyKAbhpNrJok?=
 =?us-ascii?Q?utcy6r0T57Mx/3aMnOrbMD+4kUttzUiGYGlX12ATFVFNrVV2lD5231Jlnki/?=
 =?us-ascii?Q?GkGk/pZ9K52E4OEK3nBCkDbSws38PaO8i5mLJosUgPYKra7UF33PNPnMfBHj?=
 =?us-ascii?Q?iXuDjkFqzmGO2rKzgQrePcl+ybGQ0aNONosxxu/waSxQBizCB2Pf2oXc+g/x?=
 =?us-ascii?Q?FbNcQ/8nvfBudp3vNCAoGdtJZfvzOtvItIDmOdWJdrdfcIs5dikmplvavZUf?=
 =?us-ascii?Q?m70qsoqATq1BWW7QGfGQu4Gc7Sp4OgZNYkAkyjCScNM8Y87a9Z8aiEzKkyG+?=
 =?us-ascii?Q?t1whs02fyu8iD4wg1Dr04BNAg1tzH6Z3FRWGv4lQ0wV/bh77UdgN9btPWvlW?=
 =?us-ascii?Q?PyRNX6fgKt5G6elwCyAtPqgDKxFr7ExENgyG4UHidga4NiEal4oBMPfk4SYV?=
 =?us-ascii?Q?d2SHVPQvDRxnmTU6g7/V/+Vhl0JQOJEHabPdRsOzsw0wsgNRu1hehNoLVfpW?=
 =?us-ascii?Q?cpjvv+9fK3c2oFoprBMpkxtdhuxR1vCaqUkPTCDIhxezSDYzbQtL79phjifY?=
 =?us-ascii?Q?rFfM58suibxKu1M5TE5MT/XxsOlE+nWIYmJhqFkd8VqCbpoyXqfcaJR/4qvO?=
 =?us-ascii?Q?5mCTl75NSruXU+7jtMCfLWDprAq63ERkH/wolOZXU3vnLQ1cDJtY9vOwaVpS?=
 =?us-ascii?Q?dMAUya5XrH6ogGyq5bgsQY10A0M9Vv+6/pz0QYCwG4mcrTEN8JE7Sx2F7teZ?=
 =?us-ascii?Q?gBRD76cpQaWSSdwvg0YnZGkEZArOh2ifarfmo+Q+bPf482+Kup0In9sJ62Xi?=
 =?us-ascii?Q?wNrRP2paUrZ4cc1loJJE2Zy9e197huLGTed/moY7pG5O77EesVOMt5kC3m/s?=
 =?us-ascii?Q?5tahZm04X67DQBNLuuvWVWJtyajW0VnoiWDU0Ma9kFfwv9HbJu2d+ZvI10KO?=
 =?us-ascii?Q?Yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <93CA7657F4001B438BE2253012C514FA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MNpG0hQMxPLZNx31DuPHQ/7YO1d9ifmDXiH/vM9F34/kdIEiLyajEcKn3QvN0PD8WRaKRCPoCFk6lTS8aVpN7/7O+txkvOSHTF75FmBQhRqZ7aAjsOAxYTTgyb/jdlfeiXkovg+1CX+ku45LEqDxYpv6dSLk+pExkLgohdpcXJDnJ83uHjYBceMZmrHc185U+pB4ewvbFvY/2mQl29tfYho1TBfb24VGeha7SQztlse7MFoq8YPRUTrF7IRroyk4C4KRW7+DTwO/6EtAGgo1gaJyXje7SzORFs1jZ4ttMhyhKceZcef+F/7ll1wwCeQy8BFUL9cWts133j3/o4blrajlk2qAWKe3W2IW/1JvcPGiNtqJfpH1WNmL22KAKrzjsxtt8JlhA2G6TouwvczsgpdidXc9O/+6+vsSEdoyeqHrp8cLBNbTWTNHhOoEBrZ/1Z2IQH1W+9fsRO2dZEgDbMp4wmWU+fXimJdghkmV++r4ausQUVlHXZ1c35uOeIjYskVBP4FGM3bKwEMFlVNblioB2eRSC1n0oilZxYj6gKVmhWp50S2BQSVpx0ctfkJFDGoybCKkGcvQaY3yO+/N6DwG3tIzt77RRc0k4G+g7pRkaNuWMDzICt7mtBEcFHHnCd2X1Xe+yUWHHiji+StVHJMtqLd3MUeXfa+cgEurDTgeZB3uDi1AgbcIiGNNfUnfUudjbuAmSvr05T0TXXZjYmSY/LUj1oLe+On+wgBIXTE0g3gU5bd37Bk3hQyD0+zwBcfWuppj9xaD6+GX0vFv8kbXI2Q7yxGair6+KPq+/jT73Yvvmo/XqMJ6arokb2PT
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cac6e76-5f55-4ac6-d16d-08db6b48c1d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 13:27:23.6448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LMwu8jxg3jUK5a6H+DbIyzwNv1w78IKqqCKF2TW+9zwWUe66zcwa5GtS7msL6ODQeNEIBm6cR+UPDkszc6tIQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120115
X-Proofpoint-ORIG-GUID: a_oI_u6IMSeu0eRcYPrjbcM9gIc6JtGC
X-Proofpoint-GUID: a_oI_u6IMSeu0eRcYPrjbcM9gIc6JtGC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jun 12, 2023, at 2:10 AM, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Mon, Jun 12, 2023 at 12:48:06AM +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Jun 11, 2023, at 2:07 PM, Leon Romanovsky <leon@kernel.org> wrote:
>>>=20
>>> On Thu, Jun 08, 2023 at 04:07:13PM -0400, Chuck Lever wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>=20
>>>> drivers/infiniband/core/cma.c:2090:13: warning: context imbalance in '=
destroy_id_handler_unlock' - wrong count at exit
>>>> drivers/infiniband/core/cma.c:2113:6: warning: context imbalance in 'r=
dma_destroy_id' - unexpected unlock
>>>> drivers/infiniband/core/cma.c:2256:17: warning: context imbalance in '=
cma_ib_handler' - unexpected unlock
>>>> drivers/infiniband/core/cma.c:2448:17: warning: context imbalance in '=
cma_ib_req_handler' - unexpected unlock
>>>> drivers/infiniband/core/cma.c:2571:17: warning: context imbalance in '=
cma_iw_handler' - unexpected unlock
>>>> drivers/infiniband/core/cma.c:2616:17: warning: context imbalance in '=
iw_conn_req_handler' - unexpected unlock
>>>> drivers/infiniband/core/cma.c:3035:17: warning: context imbalance in '=
cma_work_handler' - unexpected unlock
>>>> drivers/infiniband/core/cma.c:3542:17: warning: context imbalance in '=
addr_handler' - unexpected unlock
>>>> drivers/infiniband/core/cma.c:4269:17: warning: context imbalance in '=
cma_sidr_rep_handler' - unexpected unlock
>>>=20
>>> Strange, I was under impression that we don't have sparse errors in cma=
.c
>>=20
>> They might show up only if certain CONFIG options are enabled.
>> For example, I have
>>=20
>>    CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy
>>    CONFIG_PROVE_LOCKING=3Dy
>=20
> Thanks, I reproduced it.
>=20
>>=20
>>=20
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>> drivers/infiniband/core/cma.c |    3 +--
>>>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>>>=20
>>>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/c=
ma.c
>>>> index 10a1a8055e8c..35c8d67a623c 100644
>>>> --- a/drivers/infiniband/core/cma.c
>>>> +++ b/drivers/infiniband/core/cma.c
>>>> @@ -2058,7 +2058,7 @@ static void _destroy_id(struct rdma_id_private *=
id_priv,
>>>> * handlers can start running concurrently.
>>>> */
>>>> static void destroy_id_handler_unlock(struct rdma_id_private *id_priv)
>>>> - __releases(&idprv->handler_mutex)
>>>> + __must_hold(&idprv->handler_mutex)
>>>=20
>>> According to the Documentation/dev-tools/sparse.rst
>>>  64 __must_hold - The specified lock is held on function entry and exit=
.
>>>  65
>>>  66 __acquires - The specified lock is held on function exit, but not e=
ntry.
>>>  67
>>>  68 __releases - The specified lock is held on function entry, but not =
exit.
>>=20
>> Fair enough, but the warnings vanish with this patch. Something
>> ain't right here.
>>=20
>>=20
>>> In our case, handler_mutex is unlocked while exiting from destroy_id_ha=
ndler_unlock().
>>=20
>> Sure, that is the way I read the code too. However I don't agree
>> that this structure makes it easy to eye-ball the locks and unlocks.
>> Even sparse 0.6.4 seems to be confused by this arrangement.
>=20
> I think this change will solve it.
>=20
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.=
c
> index 93a1c48d0c32..435ac3c93c1f 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -2043,7 +2043,7 @@ static void _destroy_id(struct rdma_id_private *id_=
priv,
>  * handlers can start running concurrently.
>  */
> static void destroy_id_handler_unlock(struct rdma_id_private *id_priv)
> - 	__releases(&idprv->handler_mutex)
> + 	__releases(&id_prv->handler_mutex)

The argument of __releases() is still mis-spelled: s/id_prv/id_priv/

I can't say I like this solution. It adds clutter but doesn't improve
the documentation of the lock ordering.

Instead, I'd pull the mutex_unlock() out of destroy_id_handler_unlock(),
and then make each of the call sites do the unlock. For instance:

 void rdma_destroy_id(struct rdma_cm_id *id)
 {
        struct rdma_id_private *id_priv =3D
                container_of(id, struct rdma_id_private, id);
+       enum rdma_cm_state state;

        mutex_lock(&id_priv->handler_mutex);
-       destroy_id_handler_unlock(id_priv);
+       state =3D destroy_id_handler(id_priv);
+       mutex_unlock(&id_priv->handler_mutex);
+       _destroy_id(id_priv, state);
 }
 EXPORT_SYMBOL(rdma_destroy_id);

That way, no annotation is necessary, and both a human being and
sparse can easily agree that the locking is correct.

I have a patch, if you're interested.


> {
> 	enum rdma_cm_state state;
> 	unsigned long flags;
> @@ -2061,6 +2061,7 @@ static void destroy_id_handler_unlock(struct rdma_i=
d_private *id_priv)
> 	state =3D id_priv->state;
> 	id_priv->state =3D RDMA_CM_DESTROYING;
> 	spin_unlock_irqrestore(&id_priv->lock, flags);
> + 	__release(&id_priv->handler_mutex);
> 	mutex_unlock(&id_priv->handler_mutex);
> 	_destroy_id(id_priv, state);
> }
> @@ -2071,6 +2072,7 @@ void rdma_destroy_id(struct rdma_cm_id *id)
> container_of(id, struct rdma_id_private, id);
>=20
> mutex_lock(&id_priv->handler_mutex);
> + __acquire(&id_priv->handler_mutex);
> destroy_id_handler_unlock(id_priv);
> }
> EXPORT_SYMBOL(rdma_destroy_id);
> @@ -2209,6 +2211,7 @@ static int cma_ib_handler(struct ib_cm_id *cm_id,
> if (ret) {
> /* Destroy the CM ID by returning a non-zero value. */
> id_priv->cm_id.ib =3D NULL;
> + __acquire(&id_priv->handler_mutex);
> destroy_id_handler_unlock(id_priv);
> return ret;
> }
> @@ -2400,6 +2403,7 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_i=
d,
> mutex_lock_nested(&conn_id->handler_mutex, SINGLE_DEPTH_NESTING);
> ret =3D cma_ib_acquire_dev(conn_id, listen_id, &req);
> if (ret) {
> + __acquire(&conn_id->handler_mutex);
> destroy_id_handler_unlock(conn_id);
> goto err_unlock;
> }
> @@ -2413,6 +2417,7 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_i=
d,
> /* Destroy the CM ID by returning a non-zero value. */
> conn_id->cm_id.ib =3D NULL;
> mutex_unlock(&listen_id->handler_mutex);
> + __acquire(&conn_id->handler_mutex);
> destroy_id_handler_unlock(conn_id);
> goto net_dev_put;
> }
> @@ -2524,6 +2529,7 @@ static int cma_iw_handler(struct iw_cm_id *iw_id, s=
truct iw_cm_event *iw_event)
> if (ret) {
> /* Destroy the CM ID by returning a non-zero value. */
> id_priv->cm_id.iw =3D NULL;
> + __acquire(&id_priv->handler_mutex);
> destroy_id_handler_unlock(id_priv);
> return ret;
> }
> @@ -2569,6 +2575,7 @@ static int iw_conn_req_handler(struct iw_cm_id *cm_=
id,
> ret =3D rdma_translate_ip(laddr, &conn_id->id.route.addr.dev_addr);
> if (ret) {
> mutex_unlock(&listen_id->handler_mutex);
> + __acquire(&conn_id->handler_mutex);
> destroy_id_handler_unlock(conn_id);
> return ret;
> }
> @@ -2576,6 +2583,7 @@ static int iw_conn_req_handler(struct iw_cm_id *cm_=
id,
> ret =3D cma_iw_acquire_dev(conn_id, listen_id);
> if (ret) {
> mutex_unlock(&listen_id->handler_mutex);
> + __acquire(&conn_id->handler_mutex);
> destroy_id_handler_unlock(conn_id);
> return ret;
> }
> @@ -2592,6 +2600,7 @@ static int iw_conn_req_handler(struct iw_cm_id *cm_=
id,
> /* User wants to destroy the CM ID */
> conn_id->cm_id.iw =3D NULL;
> mutex_unlock(&listen_id->handler_mutex);
> + __acquire(&conn_id->handler_mutex);
> destroy_id_handler_unlock(conn_id);
> return ret;
> }
> @@ -2987,6 +2996,7 @@ static void cma_work_handler(struct work_struct *_w=
ork)
>=20
> if (cma_cm_event_handler(id_priv, &work->event)) {
> cma_id_put(id_priv);
> + __acquire(&id_priv->handler_mutex);
> destroy_id_handler_unlock(id_priv);
> goto out_free;
> }
> @@ -3491,6 +3501,7 @@ static void addr_handler(int status, struct sockadd=
r *src_addr,
> event.event =3D RDMA_CM_EVENT_ADDR_RESOLVED;
>=20
> if (cma_cm_event_handler(id_priv, &event)) {
> + __acquire(&id_priv->handler_mutex);
> destroy_id_handler_unlock(id_priv);
> return;
> }
> @@ -4219,6 +4230,7 @@ static int cma_sidr_rep_handler(struct ib_cm_id *cm=
_id,
> if (ret) {
> /* Destroy the CM ID by returning a non-zero value. */
> id_priv->cm_id.ib =3D NULL;
> + __acquire(&id_priv->handler_mutex);
> destroy_id_handler_unlock(id_priv);
> return ret;
> }
> @@ -5138,9 +5150,9 @@ static void cma_netevent_work_handler(struct work_s=
truct *_work)
> event.status =3D -ETIMEDOUT;
>=20
> if (cma_cm_event_handler(id_priv, &event)) {
> - __acquire(&id_priv->handler_mutex);
> id_priv->cm_id.ib =3D NULL;
> cma_id_put(id_priv);
> + __acquire(&id_priv->handler_mutex);
> destroy_id_handler_unlock(id_priv);
> return;
> }
> --=20
> 2.40.1
>=20
>=20
>>=20
>> Sometimes deduplication can be taken too far.
>>=20
>>=20
>>> Thanks
>>>=20
>>>> {
>>>> enum rdma_cm_state state;
>>>> unsigned long flags;
>>>> @@ -5153,7 +5153,6 @@ static void cma_netevent_work_handler(struct wor=
k_struct *_work)
>>>> event.status =3D -ETIMEDOUT;
>>>>=20
>>>> if (cma_cm_event_handler(id_priv, &event)) {
>>>> - __acquire(&id_priv->handler_mutex);
>>>> id_priv->cm_id.ib =3D NULL;
>>>> cma_id_put(id_priv);
>>>> destroy_id_handler_unlock(id_priv);
>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20

--
Chuck Lever


