Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10CF74FB47
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jul 2023 00:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGKWtz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jul 2023 18:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjGKWty (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jul 2023 18:49:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E864FE77
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jul 2023 15:49:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BIDJu8015223;
        Tue, 11 Jul 2023 22:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=CPvt7WsmBxFeqeGC5kxl4bks7drasfI5uofExqTs4Kw=;
 b=DWeys772Sq3gt0+4Z7jYg7Cw4+wiVrHl/GnL/T0sEYd+245pJY+U+Me2QQezi3N9Pf5v
 TlxQivjHDmLzejo7F+2Ld5WzL0Di3oQ+W/wloNIKwXmdVluMAuQ46hnrjcRZy+32e6OW
 SmQjDQn6uLqPRY2F7hziNhXQraErw+h5KIJiVlNkrso71cdPYU19jd5kwxJkbK6dBRXd
 3uE8hGEv7aVd0FPTgC0WaBgec+JcV1RnaKZ4vicUZrCZabk1kftbotmZx2YFy4Wno3SL
 5h32wi2H8I6RfyTyqzfuGbGzI6J+E4Rhj1w5Ehn1faYSHfKNE3XMzSF8ScpXJB+W6RTJ ww== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rr5h14p3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 22:49:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36BLtEZg033178;
        Tue, 11 Jul 2023 22:49:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx86328y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 22:49:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHhuxRNoB05vk+sUhzBrCz4Dk+u5OTn61DYOMKqGE68IWhMk0TDsavLkd5QfcSmW0x8G/yqZZ/8l9zLzQ/MMJ6XQuX5y17hU9wY8Lrz6LLYZMIcKtpL/9vHGWTzYOOprVUntO2bRIwro5AoJm+6XUzD72FahIjnHbybzcc+5IgoarAmEN5LT9D8Bg45zvZ19BZL/Yt7IfJEbeU6/GUpBQzf2msd6bNd8qSJ9pnAUaz+3M7UMvmjupheKYNs3sypgpkibrlAx1bvm8PnYs7Sdmvvw3LFCPqqUU7Diu1QFaEMrW6f4VD2xTdh8IEXNG3r5rLk08k4dk8IJICDvPkdI4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPvt7WsmBxFeqeGC5kxl4bks7drasfI5uofExqTs4Kw=;
 b=GPvvoRX4yBzKHGM7YXrFRpZnHkTiFudWvxhSG9wlnCLHf2CRVIEEaRcMv5QECMKItcyxML97eEaa7/+v1cvFL5WfhMy48g+S/jjePIyLSNzH9PWOtaPylcQjHyIN6OwYQUXJFmt0RX3LowKWVY7AGOsUH8mEcgMe55vdAh12gwxm0dOZODEXNHUL4yKTrx+jvgYn/D+vJvQDH9osA/2sxbW0LQAunpsEaWoIoUulOkCniHxkyOQUDwt4KWqXLDm7Ew140ObKgSKqDOIrkImGlE39OGaSmRIs5QQCU1e3tn7XXMhx0ur1A4kDtz2VYnY74hByN3c9th9Ydm47mkbXbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPvt7WsmBxFeqeGC5kxl4bks7drasfI5uofExqTs4Kw=;
 b=vZ7U3XVWsoRNpn8QcwKNULkW4mgM5BN3o1699nh1w/Ez93t2iiAEVjjMUSpgecNwyVyBW27QN/82j/9WXuNAeTBjFZInm7FY70iHlkaAl2StV79sCSkls067+yxjHtAQTE9HE25HySQXCGjN1RTYrpygCSeyqAkKvrNBB/aCqeE=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CO1PR10MB4803.namprd10.prod.outlook.com (2603:10b6:303:92::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 22:49:32 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::9470:898:d13e:f870]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::9470:898:d13e:f870%4]) with mapi id 15.20.6588.017; Tue, 11 Jul 2023
 22:49:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Tom Talpey <tom@talpey.com>
CC:     Chuck Lever <cel@kernel.org>, Bernard Metzler <BMT@zurich.ibm.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v5 4/4] RDMA/cma: Avoid GID lookups on iWARP devices
Thread-Topic: [PATCH v5 4/4] RDMA/cma: Avoid GID lookups on iWARP devices
Thread-Index: AQHZqpy/MPzrGTHOK0uAvlJLASL21K+lG7GAgAAA3ACAA3LzAIABIZyAgAAInwCACZLmgIAB8gKA
Date:   Tue, 11 Jul 2023 22:49:32 +0000
Message-ID: <3748AE3D-95E1-4C22-925F-FA24740D1833@oracle.com>
References: <168805171754.164730.1318944278265675377.stgit@manet.1015granger.net>
 <168805181129.164730.67097436102991889.stgit@manet.1015granger.net>
 <1132df9f-63a1-f309-8123-b9302e5cdc3c@talpey.com>
 <7F4E0CAA-A06B-4F43-B019-4E471B10DDE7@oracle.com>
 <ZKM4jM6Ve5PUhHFk@nvidia.com>
 <a8f54410-f680-190a-5e00-3226f186b2d6@talpey.com>
 <50C32C40-D3D8-40CF-B332-C12FEE894FDF@oracle.com>
 <ZKw6rySZlRLCls+L@nvidia.com>
In-Reply-To: <ZKw6rySZlRLCls+L@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB5134:EE_|CO1PR10MB4803:EE_
x-ms-office365-filtering-correlation-id: da34b858-416e-4ecb-efa1-08db826117a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eGeyfClgAgFrH4ak21uMUhi4F9enqopfG2TVD9FWO1lU8oVtEBcZYWjTGvV63X3ksoemWk52BDaiWQaBHfB2nEUpwAji20e/GgF9rOYHyi9WXxsCdZ7PG4Ic8xEsFuummglrbTffyY/5puMn6a6sIkTubz7whzwcRuwWUV9iYhgU/wTeFYtibzlpj6y1Hz+gqdnTfOebSUyRrLphlZPeIHMajJ0Fje7htgOnkXpskG2TDHQB6ZYzLRY0JMtqDA0M3JmQNjrh5oyEAu2mDVsxL5q+X3AkNnebFrYvSFoh70EG2ZyutxMY7/YM5RFaaYIzCphrCOBYylfEJcD8iTytPMzyEPXJMZMoYIPIwxxyGtx9bFbBFPtM6CT3iHa2Jv5AuOGmkitPcOOgAqJtg6HOTrB7NxAP3rgpdw+FhyvMdcA15OJQbNXgPO4IlresF+dfjnzR/AKR43YrTRooqg2U4WnviWldr7mCMy85SanE6iupT4S9Y81uHYioJsY9slbWls75HeMi1Ngia6f/Pj9UAW0tx5YOWcoPOaw+zrq42GXldyLDpvWlPiltflW2CX9rfbtzBAEvF2TUHmfzobHfT1zkrmS6YYq+95VXCG3P/Pk7uJcYvZt4ifUKa5xlc5/rxo2IUYdhvk06IGUBeG8Umw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199021)(86362001)(38100700002)(38070700005)(71200400001)(36756003)(54906003)(6486002)(76116006)(110136005)(91956017)(122000001)(6506007)(33656002)(26005)(186003)(53546011)(6512007)(2616005)(5660300002)(2906002)(316002)(66556008)(66946007)(66476007)(8676002)(8936002)(83380400001)(4326008)(64756008)(66446008)(478600001)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gUa4rzQtbBb1IIbomFnIS88EEVPMi2MvEoIQzSqAVWBQ+3Cmx4bIVjnCgNZu?=
 =?us-ascii?Q?NKCoI2vL0sCUssvYSghKGuXPRzFXBZ79hIleeW7rpGqPFEtnAmuKngBhkBiU?=
 =?us-ascii?Q?OUHxBoxBIzI+2d6ve3U+6TEmMT7dIyOdoJmWSRCk/2Gh4XwDk2N0l91t4g/t?=
 =?us-ascii?Q?Ib6UC1eev1f4zCRYp+/lDi6rEn9Qt3odpNWVLWdVrRnOV0hK5dEfKDPmlyfu?=
 =?us-ascii?Q?S9MVPTgRB5dVMOwwrlKyZqFffCe9LtRODRNbGePA3SZjthHlolUp5QkTCRHP?=
 =?us-ascii?Q?oglok+q5LAkcF0/4wlHAL2zBh9Ff42BH0TM72nXPeYeLU0H9qsbZ9c1JNORb?=
 =?us-ascii?Q?biEWlJpPBtcSszfIt0XAD0w9tPym9OU5xyY2lAbEIr1HT9BLJ5+SucUJHbaq?=
 =?us-ascii?Q?vHO19KvakSIvgiDS6HPB2tD2G3lDRpnp7ODGkBHC7dm6L2DlgFngX0Rmw80R?=
 =?us-ascii?Q?HqAadfGi2h2XSGbf+UZ3bH5dfwpLugku26acFw377xKoj/PFAyQKU7qK6xiQ?=
 =?us-ascii?Q?YLeVw9l6I1HaG9X2+3BgGrxVy7PwYQv2f6UbnVthk/gJTWUNDy7RrIfvGHat?=
 =?us-ascii?Q?VioZsZhajKZn3wCCg+gT3J1Df3W7ljL2Z647naSjUNisOQR2S9+dzc/nUUmV?=
 =?us-ascii?Q?FPF9t9zVXTOm/F/wyPRkqvkkCntnkFBwv6Ktql59RR4HOxWVniP1jRyOpjDN?=
 =?us-ascii?Q?ZS50dGqWm95T19QvE91QoaGkYe3qKoyP6z1SodA3FWbI8spu42Nqgb+fOMDv?=
 =?us-ascii?Q?GPVliN0/4ynYNeaZSUpzX+rUXlTMsW3Pe/2BKZmGZFpd2Tpb+DbFRCi4MLTW?=
 =?us-ascii?Q?ztRt7xoiIxXYtDc7yb/z8sENOoy0nob1i7GnFc8s4M4CsmYgW2Q8FAgnc3vN?=
 =?us-ascii?Q?dLlLTHS+B4WkR//E+uyMN5N4XUuItDsomOEt1yAssMYrPxzBb3U4HPpjtIfm?=
 =?us-ascii?Q?u+N2VExE98V1fpTuOR6UADsCFA99jA7XNpve5c7HFjAHCIa2wUcxUrZgcZfj?=
 =?us-ascii?Q?HulorHC6DZL0qUYSRPqoUQ4zJ/1bDotjXrITxNlzT14QBIeEJsSWZyD5a81C?=
 =?us-ascii?Q?sXGdeZjZG5NKgPX2A/PTRJ3XzwMncn1s4QlvB7mPWsNibQ/bplBj4CurQe3Z?=
 =?us-ascii?Q?p2kAyq8LHTcyMLDKRPpyilAbgcNSIUvjP3xjDSMgIramMbBYA0RtV6cUYInU?=
 =?us-ascii?Q?yUax1Mvtp4Z0q03WDbLMQl5wSn4vQtWWjlS8pMjrcn62A9oYmDckIxnz9YOO?=
 =?us-ascii?Q?/cbT40l/xLLhDaX+qEP0/nmaxv4KwBHUokXmg18LCxtzAs37yxxGl/942qHg?=
 =?us-ascii?Q?HuItdd3CtwMchqE5+xwpfvLobJuS7ghPfzvF06ZgNsxP+Huv5xeUGnwTdcUF?=
 =?us-ascii?Q?IeSuyp15V3k0vs2A1MMjxapQxMSHMzykyurLR34+PiX8vzX7AOLoHsK7Rgkj?=
 =?us-ascii?Q?TrIQcysTAZ1x6HvgTb65a2i28B8Z3o1574fP91o35RBksPxe+TFi0XQS8FYP?=
 =?us-ascii?Q?eML1ZkgYxcWmDUT946yEsWR5WgtFyhrKzGiZNBZi3MGWSemS5ZYwgGKLdVJj?=
 =?us-ascii?Q?nhFOKq3qdY+QP25VlrqDrC8e0sUTBj59GdHHsLfsQ+2UfOCB2gdYrg3JCMpY?=
 =?us-ascii?Q?cA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6BD8A889C1DBE2458BFDEDD507D65F12@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MDjdFkC26E12BPFBqiZPm3Tfg1ShpKhCoqrJtqfadTRf5bR+WTpptm5PGBGiyXc9tbhV0DniCsk+BXXcy6l/K8bbAR2rqlz+QqGTdo2aXa4SXx83vH9U/G/sAW1GzQwldj+Mi2V8YLH+V1YbuEPJUZzzLxVWlkH0gxw/fQ7YxGA/6PWx7UvP75VyNDhZyF3a7ONtPw9Cr2fchnrUnv2Ksb37mssnu74cBQhbJUDZYVJkoUcC9UelMiRWVJuzfl2lSoe2OLNIFasZFxkMXeBog+eHZgSzc8BII8dMaKlcZDBFtzaW7zqW1X+O8Hiul3oL+k3QQYEywxhKMTmAvjg+65VM3vD95AelC4edUMmKd5a3rxnurZZxtWGkQuvVMBl7vRyPQLmQz8lz/qzwFi/cIqAVh9Z0MLxV1ILxkUyWX7VzCGB/kowe8ii88tL+Ok87+nhd2LrCMaxzhtquK4rYvOU27FhxGhv301uimxSyd1l2E7LeBFTKqRhJ+Y0/aByYbcaJtFWnW277ue3n3gt+1T4JbUOWKSnzJwmXR8wUXhr4mOsJvqVRqbYQo1kV97Wj9uRsAiwGlNyI1Z9UnSzcqZ/gfgosDwdAvAYok6MV3iUbKVTxPlnUUmZ4Zm/pDiqSnaVXqU5Fn7u+RaA/h5d7hBnesMyn8onbz7VokaK9bCVHSt2D5nymZJtOCeOm7umsgliNyo9mVG16JHgG9WNmUWOjHhgoOOUmDX4jVG/ijrO2CDFs9luU7DhI/I3ZCe2o8ZLZwNEL2bb/tFeRG00d6dzVZPEYc1bSr40Ke9ZRxM7q7MtCAv3OVce30FZI6fuDPBA5t2pTNQW1+eTfc7bA48KhvdZhbNhAmzQEZAIB/aFNUnLMMp0/GByyvaEJyMtXQMUPlkMdxzGRPf2cnFyR6ejAlh7Y185oGO+Gnaalkd0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da34b858-416e-4ecb-efa1-08db826117a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 22:49:32.3092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SeZ5Lg2nE5zNW4+i4DrW0CVIpTdIy+RdbxXIIVK0Nh28nPIUhM83goeSjTiijwnqVFp3uteP7xCwxviSYQIgBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4803
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_12,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110208
X-Proofpoint-ORIG-GUID: m6bw0ixL-BkmHIbWQl_YFZg9eJ_2rV-W
X-Proofpoint-GUID: m6bw0ixL-BkmHIbWQl_YFZg9eJ_2rV-W
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jul 10, 2023, at 1:06 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>=20
> On Tue, Jul 04, 2023 at 02:54:59PM +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Jul 4, 2023, at 10:23 AM, Tom Talpey <tom@talpey.com> wrote:
>>>=20
>>> On 7/3/2023 5:07 PM, Jason Gunthorpe wrote:
>>>> On Sat, Jul 01, 2023 at 04:27:23PM +0000, Chuck Lever III wrote:
>>>>>=20
>>>>>=20
>>>>>> On Jul 1, 2023, at 12:24 PM, Tom Talpey <tom@talpey.com> wrote:
>>>>>>=20
>>>>>> On 6/29/2023 11:16 AM, Chuck Lever wrote:
>>>>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>>>> We would like to enable the use of siw on top of a VPN that is
>>>>>>> constructed and managed via a tun device. That hasn't worked up
>>>>>>> until now because ARPHRD_NONE devices (such as tun devices) have
>>>>>>> no GID for the RDMA/core to look up.
>>>>>>> But it turns out that the egress device has already been picked for
>>>>>>> us -- no GID is necessary. addr_handler() just has to do the right
>>>>>>> thing with it.
>>>>>>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>>>>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>>>>> ---
>>>>>>> drivers/infiniband/core/cma.c |   15 +++++++++++++++
>>>>>>> 1 file changed, 15 insertions(+)
>>>>>>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/cor=
e/cma.c
>>>>>>> index 889b3e4ea980..07bb5ac4019d 100644
>>>>>>> --- a/drivers/infiniband/core/cma.c
>>>>>>> +++ b/drivers/infiniband/core/cma.c
>>>>>>> @@ -700,6 +700,21 @@ cma_validate_port(struct ib_device *device, u3=
2 port,
>>>>>>>  if ((dev_type !=3D ARPHRD_INFINIBAND) && rdma_protocol_ib(device, =
port))
>>>>>>>  goto out;
>>>>>>> + /* Linux iWARP devices have but one port */
>>>>>>=20
>>>>>> I don't believe this comment is correct, or necessary. In-tree drive=
rs
>>>>>> exist for several multi-port iWARP devices, and the port bnumber pas=
sed
>>>>>> to rdma_protocol_iwarp() and rdma_get_gid_attr() will follow, no?
>>>>>=20
>>>>> Then I must have misunderstood what Jason said about the reason
>>>>> for the rdma_protocol_iwarp() check. He said that we are able to
>>>>> do this kind of GID lookup because iWARP devices have only a
>>>>> single port.
>>>>>=20
>>>>> Jason?
>>>> I don't know alot about iwarp - tom does iwarp really have multiported
>>>> *struct ib_device* models? This is different from multiport hw.
>>>=20
>>> I don't see how the iWARP protocol impacts this, but I believe the
>>> cxgb4 provider implements multiport. It sets the ibdev.phys_port_cnt
>>> anyway. Perhaps this is incorrect.
>>>=20
>>>> If it is multiport how do the gid tables work across the ports?
>>>=20
>>> Again, not sure how to respond. iWARP doesn't express the gid as a
>>> protocol element. And the iw_cm really doesn't either, although it
>>> does implement a gid-type API I guess. That's local behavior though,
>>> not something that goes on the wire directly.
>>>=20
>>> Maybe I should ask... what does the "Linux iWARP devices have but one
>>> port" actually mean in the comment? Would the code below it not work
>>> if that were not the case? All I'm saying is that the comment seems
>>> to be unnecessary, and confusing.
>>=20
>> It replaces a code comment you complained about in an earlier review
>> regarding the use of "if (rdma_protocol_iwarp())". As far as I
>> understand, /in Linux/ each iWARP endpoint gets its own ib_device
>> and that device has exactly one port.
>>=20
>> So for example, a physical device that has two ports would appear
>> as two ib_devices each with a single port. Is that not how it
>> works? It's certainly possible I've misunderstood something.
>=20
> That is how I would expect it to work. Multi-port ib_device is really
> only something that exists to support IB's APM, and iWarp doesn't have
> that.
>=20
> Otherwise verbs says a QP is bound to a single IB device's port and a
> single GID of that port. It should not float around between multiple
> ports.
>=20
> So, I don't know what the iwarp drivers did here.
>=20
> As for rthe comment, I don't think it is quite right, this code
> already knows what ib_device port it is supposed to be using somehow,
> so it doesn't matter.
>=20
> I think it should be more like:
>=20
> In iWarp mode we need to have a sgid entry to be able to locate the
> netdevice. iWarp drivers are not allowed to associate more than one
> net device with their gid tables, so returning the first entry is
> sufficient. iWarp will ignore the GID entries actual GID, and the
> passed in GID may not even be present in the GID table for tunnels
> and other non-ethernet netdevices.

I can make that change and post a refresh. I'd like
to hear from Tom first.



--
Chuck Lever


