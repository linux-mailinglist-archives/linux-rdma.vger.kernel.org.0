Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E814C73CC0E
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Jun 2023 19:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjFXRdK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 24 Jun 2023 13:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFXRdI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 24 Jun 2023 13:33:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C98D1BC2
        for <linux-rdma@vger.kernel.org>; Sat, 24 Jun 2023 10:33:07 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35OGlj5V009024;
        Sat, 24 Jun 2023 17:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ivKwYArIHFrWP4iZsSwZg4FQITkYh5iwGHxMpwtGlv0=;
 b=wG2b/CNb8L7O/aypMu93tDirPYScHbkAybGBG4u+5blpol9gwvZuqsoPU7Pe+uni+cHC
 qvRd7jZRNX88t2F5miJopdGYI7ROzvaRseGo0Zoirmy2ZtA3Fej0Elz9Tdm5feWt2YMT
 eR7+LWEEv846DPxxQUsBqRCQDtaxGtwYRnD1m6mR3wLpFnvA9KczV5n7oTSS1+5tUh3J
 7MtuB/u5Wbtsyq0/pccw4VNhN5295/1pbRur5BSie76g/mkVYb5j0slKYP6jipTLuo0T
 2hmfx7XMOOu05oJPI/4K6MRk2Y+KbU/8eYjER0j4vcu7ZkxWAmCVMXuCI2K7hDERO50O /Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdr3tgjuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Jun 2023 17:32:49 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35OGcvZX018852;
        Sat, 24 Jun 2023 17:32:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx1tby7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Jun 2023 17:32:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcIJgmPAj/Ndulz0endZP405kpaSBmpVhg9kVflUPNEJfac9RnIaH2UDbwoeP3Hm1TZLFm6jZrFmnCqXn/RKvr8l47ENdlL8RULeE3qXdLCPhsIUBml0m23ZsDE385Z16/XbQslrjU007vLpOxNWorzhVJ6b9A6b3ggn9wrPnX688ttbUp55rP2Fc2PUXjzfzFu72H2uWuzGQrly/yX+EuwcuZUXuEGDqMlVc9J+LvT9QklRwc4WYh0LDEJ0eqdQ9uzAr6ZS6egtlJEZAfw/tgq5g6x6+NTNKCwfuecpfhE2VUS2Th8ilNfuxecajAPxhNHRnADtPbGy4qNlKIx60g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivKwYArIHFrWP4iZsSwZg4FQITkYh5iwGHxMpwtGlv0=;
 b=iPw/lL/ZM4XH3Fky7ou6xGoh2aq4tlwm4xtEQhIa2kHGIdeLO8ishkJTQVUQfiBUYSEQ5EMRzPX5ZGaBrczgDgAwplXuY/uK8j5d0fI4TCfAZpWqjXWvPaKP4LY5zfPf79p7/B4fweNb6nKfRQBIv3R5AQ+fdOpqJpj94MW8HoOSnoYuhxbV/alpJDHyU3N2uQ+mJvb0cT4xKWQfvUYYUe5qDAIlVUN3pzeSZWDq4hsD/l6UBitKVnpAkgrgzO88D/b/GnMds4sr4HLi3/ERDXY7zSSklypZ92F0MPG5HfsJeX/RFKDkuPD15BnIJVV0Plr7ynrBWFb3yOM2QNJuWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivKwYArIHFrWP4iZsSwZg4FQITkYh5iwGHxMpwtGlv0=;
 b=uhbx0Nltm73VQkQBy5fTS45uBACBzrNOL5aBa+3BunmvwPsePfwHvbsMafNIqO15Ad0QR1j9pH8Bl4GeU2GXl+ZBBwvb0QnDZYaNH+hYE+ooxsyEwIRL36+egJrGPDLFadlTtNlbCnuK9ATQkoLFUWy9pXweMrroxc8wBQt5lAI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5151.namprd10.prod.outlook.com (2603:10b6:5:3a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sat, 24 Jun
 2023 17:32:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6521.024; Sat, 24 Jun 2023
 17:32:46 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Zhu Yanjun <yanjun.zhu@intel.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "parav@nvidia.com" <parav@nvidia.com>,
        "lehrer@gmail.com" <lehrer@gmail.com>
Subject: Re: [PATCH v6.4-rc1 v5 0/8] Fix the problem that rxe can not work in
 net namespace
Thread-Topic: [PATCH v6.4-rc1 v5 0/8] Fix the problem that rxe can not work in
 net namespace
Thread-Index: AQHZpISt3gSCMXjMdECcA4u/vL0JHq+VxWAAgAI2cwCAAGBYAIAAtd6AgAEgboCAAAg5gA==
Date:   Sat, 24 Jun 2023 17:32:46 +0000
Message-ID: <9DD4E3B8-7FA1-4054-8AC0-85FC96D710A7@oracle.com>
References: <20230508075636.352138-1-yanjun.zhu@intel.com>
 <4f097d4a-85f5-392f-53bb-85ca0d75e16f@gmail.com>
 <fbba95ad-a0f7-435e-c152-d6094b70bb1f@gmail.com>
 <8e13254c-f8f5-f9ce-14fe-f8fd21c0c6bd@linux.dev>
 <3f472f86-43d7-037a-d7d2-207314e183fa@gmail.com>
 <05d4a5d8-9646-49b0-9d7f-19d8966a308d@linux.dev>
 <MW4PR84MB2307BB2D7AC00BE3A63F6D5DBC20A@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW4PR84MB2307BB2D7AC00BE3A63F6D5DBC20A@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5151:EE_
x-ms-office365-filtering-correlation-id: 41b3144f-3cc9-418c-a5a2-08db74d90651
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y292I+wBUYzpw59p8AQ7i23FvK4vVTjohAHdf+8udUqb8cdNlYS0h+gemNGeObLK523bJ25B+q72MisnAWuTVS4W1rVwLlgICixhd8FZ5s8WzOaMCfsPbsqnpc3syCqjlCrxogKS6QEP/MEWNgH+5xr7NH/7OVpap5zbLnzgeDGcwKxF8DWv+ZxqMz98rxDcFvmla2eZ3yRMB5IMPXO/biz/3+LRSwBdgU33Z2KkfJ7gJlmh9niOc7ZFZx/E4a/4m6sfcoPvz/7ip4un8bMaLePrQG3VmQ09fr2+hA4KdeN5+UOUxGia7e4kVDCAbfb5xorwOW6aVLF94lrQZNDSFaOyTGz3+YyefBVQqBHkrYWv1CaJcqROnVVWwZ4MwW5ug6G2RIE0+X26DKvDz98MZ6zZZaOcLkMPCe5k1Jhzvu8WBr8xXODZ2QE7wxiBSX+UKHJ3EgRGtCgvImXAhGBmNCK0c+CGz2HqR+nAIL3CxucQb3GIPlAkwCcEArFUEGpkki/iPv82tXtxEEQSgMGsXqXQB50ud8WPg0xowCWJXVCJsaHQclcnKKYGCgsgmqHWG7UJi6mu8d5n0w3QygAHkjY6EkLMTOBZVu7KCc9jN1g5xoeIT09Z5tDSdqINnw040ezbk2Ncii/OFjrdON4ctg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(66446008)(36756003)(33656002)(5660300002)(86362001)(8936002)(8676002)(41300700001)(64756008)(38070700005)(66556008)(66476007)(76116006)(91956017)(4326008)(38100700002)(122000001)(316002)(66946007)(6506007)(26005)(6512007)(4744005)(2906002)(186003)(71200400001)(478600001)(2616005)(54906003)(110136005)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gGLP4Eq3SXgEPzsqFJlK8gpWSZ+V7Z99OTS+Af0R/qPhY/5QeyCVDMeR02XJ?=
 =?us-ascii?Q?1G8RHd43ZzMaVGR+mgPvKt7yTJZcrrK+8oHDa28GdOTpz3vnTyOolcMQCy+O?=
 =?us-ascii?Q?X/hN8nkqzccwlRppsNq1elN1iyIqadqYeWGSrDNFPkFbBG/gcDg5RRj2mJOc?=
 =?us-ascii?Q?g+o+7sOI1U4zTHzxUypX53ZhT12ADvFY5SeZP7mu7yyze/uC7uwo6NY2I8Jo?=
 =?us-ascii?Q?iXFj/i3ZKzmPIDXYb716YSw22wG+y3NCg8uizs+SNbQuMb7fd/6pH1PHq01x?=
 =?us-ascii?Q?Mf1Wk++IoiMb5Yx/AZboOuVzFN3wZDfpVNUgFOy2gyF1QaBJgWsoj6zSI8Xx?=
 =?us-ascii?Q?3Fg8dwtAMJpOmLloJmNTcCHnzmOvCSJ7uNWBRpbudMWuFBcRDkqhG1rmPvLr?=
 =?us-ascii?Q?WvzuuyvmxzquuJ0CElEP8PVvU8cTLFXqqzcwe9Av4QXwOD345KIFiiyFus63?=
 =?us-ascii?Q?hqzzcI0ko/4eeor8eY/NVx/H4fdLz9b5IEeOBX1U+0X3K6z76TN2t1Sehcxy?=
 =?us-ascii?Q?XobzG7LDaVCAql+0etcNg9IfH2jzq42nWmMZ+8JrHmyi37gCzbaIChizHZ8+?=
 =?us-ascii?Q?dv6udV0mCYUWu89MvQP1oUFK0PUZYWKbA1nwi6uJj1abFBufXCcZaTPiD7YY?=
 =?us-ascii?Q?oJY3dbBOPKurwYa7jRxzBIZ4kGSwANbOKKfISHN/m9HETzbH8e2zS5nmQMAE?=
 =?us-ascii?Q?0yylzh+dzEqnRC5oaDz5L+BFuJKI62HA3TjrcxR0IWQuRGbdsWVAB11RW+NP?=
 =?us-ascii?Q?Ouyr7TrWJYpXxW3K2HFo5xDhP8l2Hgp0IpXmTmEXNtCEbfMA8Tl38wSzqPlr?=
 =?us-ascii?Q?GLr95iVjx7O56BTIDrLBi794nZaMnlOgSrsdaleHKPRitDiDoUZlp1JO5d25?=
 =?us-ascii?Q?o6CN6speuynCSd4pe/MxFY64UCNKAgm41PSedhivfpoScCumEE6c7j5CTj7q?=
 =?us-ascii?Q?D9e+HH9d5uGauTeb1dtUiEy1CUyzp+rsJizYqje6TEMpAwB7DSecFBPQQ2Xk?=
 =?us-ascii?Q?6PDoTZZCDa5yXtpwJ9H3w8b6g1puX/Nf/zzqnV6ohvCi6OchZSjcfJP57H2f?=
 =?us-ascii?Q?NcE56Y6vacIH8m0Eg+3i0FIF2WmvNCx/Rv+OzPOuN8lCPF+KyAkRr5abZ+AN?=
 =?us-ascii?Q?Zmxm41XUzfAfCmlbkBDu4SDkyxzMFMpjlFwem8NdsvuHhr0fBNjcYuMJqmIz?=
 =?us-ascii?Q?m3bETmoCqDn/9ZnEndniRbcPCI4resUA5NNEWUrn+B1ks7Vm+6UbkhayHv6L?=
 =?us-ascii?Q?VtK3GztbXx+GPcTN3mpCZKKq2uQZ3J1HEnFWzJ9dIl7AhsNnlB5TDBJkqjzX?=
 =?us-ascii?Q?xuDDbE9N32z0DvfQ4Ou6Ifp4UMSPiN3ih+lgpTMxGBWPmevDGxqEZctHQoj+?=
 =?us-ascii?Q?uDpr1VOveXaU4a35TvDuQjC+VJ6coFFyKXhQkb0UuKmJhXsUf2wrN+8vYFb1?=
 =?us-ascii?Q?X6sn8gGtp2GbjDr3AJc/j5hLFsEORlviDJ4VDdRF3SVtyCoWA8WDKkjoA6dm?=
 =?us-ascii?Q?Lzv/Ed2Kbp1aVqFDgJQpeZkuYpqs508bne+LQNbOFenbm4z/UVRRXEPAMM2h?=
 =?us-ascii?Q?FIzwmgMgqTBsc2QehaWL/Nu9UZyDEPxXJL4noHnzc/SEPKWAifIB1lCAcYSh?=
 =?us-ascii?Q?Yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9988BCECC43EC74BA11022388C1DC3B0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xwwPFIh2jPD2CcTiPOQN7zC9q/l6qAhIguylL8H1xdOUFLNbNT1x5fixWsBSX7xFnAu8OLI56VdGuEueSNMUtQggWV+Q3OHGNdErsAbLCkisyFsjADecAL65Rgtfo9JxTYOgTY0lJ3fSl1oRp1uBzrRXM7G2ydgsggNwqj/y9y3ckGDrbOKPqlDETz+VgbYUlvmnhfXT4208XTAbM+1/zRmzL08mLet27EkklyWI3t/WVfXq66LVaGXBLjSnrfZx3WVgygODgglv/Di58UBnO5nJmK03nBxzjT1fU4G/ZqYoj3sVZMh/8HGZQOuXUJba2JiubrDVk1Pno69NtFPnmHf0iKZwHLh3jji09ACoGvUll4s3ENM//6Bwg2v37ANz7Sgt/xGSE+Ppcm4dIrCyhrDX808ic34D5LBke2ewErGyQOKLvACl1UsdD91OrcrJDaEVbPmvxHWYezuK6aFUiTu+bhkRGRP2VJsS9uWQAFXthF+s8MHnDDifYE4mTrkh481eY0WgcHIfmAXownCqtiTWPn0KJ96d9BWo7aRWvzGV6jL7b/I0JZwwFrb9R0Lmx7kNw57++FnZFK7C2E/NsbdSSMHX4V+UspZbD+NKXPc/868i3O/X+u8QlTR9tbrGY/sN01dCVyecHuKQ6FR8fh9udcPRT7YnGe4Gn3d0qEUHgyyyd4jDHz6yPgsThFvFZrwAYu0QlKmF/C+dCCpIUzNnm6O6LVOrT7KA9kjHunkh9zerwg9bHu+h77suIopeJWmj6F980KpVEam/QKF2rEtMZ3oJyiywcuJVA2AgHFkvmNQ7PDQSUm0i0iW8USeVenIDCHjZz4CaEusn+RIHkbon9H57jvsbcq5ICwknqPfy9B2Vcrf3lXYcWaCTX43+HKHpo/bikN59WnGvYlRGr5+gqEq98/+4Y7PmQC9Yd/4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b3144f-3cc9-418c-a5a2-08db74d90651
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2023 17:32:46.5695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2qoBhyv/pP4FJCtwXrQyS1ki3Q50CntOecFMRSaUb4X6POleFfT7rZ5Lw4WkJbY9lbP5D7B5ZS1oWdPEf5xEtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-24_12,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=819
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306240166
X-Proofpoint-GUID: 7lKkfx3zOR4zWXrOI6XUKmm4oM586Aat
X-Proofpoint-ORIG-GUID: 7lKkfx3zOR4zWXrOI6XUKmm4oM586Aat
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> The GID of rxe can not be generated with lo. This is a problem.

I agree, and would like to see a fix. It's obviously going to be a very
useful use case for CI environments for upper layer storage protocols
such as NFS and SMB, for instance.


> Now Chuck Lever <cel@kernel.org> will fix it.

My understanding is that, because RoCE allows more than one port per egress
device, the mechanism for enabling rxe-on-lo is going to be different than
it is for iWARP -- or it might not be possible at all. That's why my siw
patches do not implement a fix for rxe.

Jason needs to outline a mechanism for it so we can see what needs to be
done. At which point, any interested party should be able to fix it.


--
Chuck Lever


