Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF33B355728
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 17:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345379AbhDFPB6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 11:01:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57120 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345378AbhDFPB4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 11:01:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136Ei8IK124914;
        Tue, 6 Apr 2021 15:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=GFKswS/+b2ykB3CG9v1x5f665s+dCHcntavIdGYUGL8=;
 b=zP1lK6GtIBGlIe0Lv5C44VbGyk1lluNFoVmKw35Ls2AnopQqcP+V4OUjMeRfStlDIsas
 knGetixrUVBAeVbLEs5AAA7ys298N0+yaKfTREXlCqVomdg5OP78koMIZUutk9Xxn7xW
 E6/gJDzCnUT2SUP3zYwvENboqrw1AmvVjMbuhQdNUZfzrQHYcwdOLqddoEpFtyxpf3uA
 Mo0hwSCX8L/0GI//sOS/OFd8fa/9LqGi3IEvpqKksZdvxjZiLBZ5cWtmC4gyiCtqV7hv
 UQw9x/8gJyu7znovv+9oj1LLbOpq5OWr4ifc8cArdEdkYdU4nR3jrbH8FC/6o1KDfJ5J Ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37qfuxd5t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 15:01:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136EkCuV095784;
        Tue, 6 Apr 2021 15:01:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by userp3030.oracle.com with ESMTP id 37qa3jjfmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 15:01:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJrvPTDKFYEX6mw0XcGyiF4y3dHu2Zt6L3bN9zAgQUqywFzQ+DfnaM4W5nNMg+TN4o22BfOFlTcZIRxqnxlCIKMh8tfGtwun7AN+T1MEWScgDpTU9CGwng8EgLxbcfFeSJNbu2IvgDoFjmgbAYahCDQq9hXxLzrYw5kda9MYKFoMDVkqbL85/o6E3/fdDyHPU9mH1cdg6uuxE9NVCXm/2I0h6+6xrOZz6ft5aJImeOZQHUGESVHjjdM+zHeKrVGuSFzCNL4MJdFxE5q94PPSYEjHtY0rFsv4ZkQNiigIxG30HO7/067OE1tvaPUO7aq/0Nw7YAaeoY/Fc8/SfDBAaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFKswS/+b2ykB3CG9v1x5f665s+dCHcntavIdGYUGL8=;
 b=NzVGF8MNC4lycv7J8I91qe23Rd7d2QB/PB86bq7lM6/rr8JFHOygbCDZ69f4PnTOCws6/vWvgXALNSDB5DgPZFnIuRwUSrZPD7Mixeqq/pn8KUZpn2CcnrCDcU84DOznGsNMxVs09jfnLQCv00KlfwEc6Y+1oJH75ZINWEWfJXs6WXV0dE/iIkT4AywGJB1nDb4RlK6S29HyJZwh09fgkMDvcJkPut0koSo4JrljuSz+f4vPmL/QCMoatyVvw/crymYFC6Hd5vapKxLQcofIP9PFQAKbPArxcMrCU9PxZAmIbiE+rkkfxma5ctP8TfDMquq2qUdO4homUGP54NFQ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFKswS/+b2ykB3CG9v1x5f665s+dCHcntavIdGYUGL8=;
 b=dySwpMj6X4V3M5C6KjvrgVCKF7g8ha6+Ov68Jt2jdQu3nrYW4J2x9KG3cgwTCyV0mWy33VR2fEWJCgRNXi96JnemagXOsO35DdW/K7RQ8Xli5TI+GxjmP8MEDl8qMs+GhkdDJvbKgSiZsEcL+qTE0VXp4XhjJmYd9UGJ4G4OxAI=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1253.namprd10.prod.outlook.com (2603:10b6:910:7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 15:01:41 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 15:01:41 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
CC:     Leon Romanovsky <leon@kernel.org>,
        Mark Haywood <mark.haywood@oracle.com>
Subject: Double RESET -> INIT transitions
Thread-Topic: Double RESET -> INIT transitions
Thread-Index: AQHXKvXA8fgjJCWRlUGbA3d9c3jDYw==
Date:   Tue, 6 Apr 2021 15:01:41 +0000
Message-ID: <F6F7D0C5-ECA6-43C5-91C5-818076C5619A@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42550f51-6c2d-4257-0f17-08d8f90ce2b4
x-ms-traffictypediagnostic: CY4PR10MB1253:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR10MB1253E30A13D458B4616E5CF5FD769@CY4PR10MB1253.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oaw5Ehs31g3D98lnN4vgZQqxPSsNO6KyrcT7pRuymU0mTxvKmm79tnsQpSovVCBMS80jdb9Chx9CDqzdME/pD3+9BHTSsPE56Rqh6kVEqcUOhJ7mqlUcWfz4PpoR1YQYGxlcutsVwvSOKls+JusEtDNvNNl96BAaDnbKWzN4jdQlhkJ5aJ9lg3QQvA5oxqe2A/RctSQW5XMxzZkQCfppcNQcPph3inVbPCzsSlgv5VI/glTHwSCn1EKmexmT/ifWXvCvlQ8RhGjakeMfAW/DkV2K3UPJJ1nMCFqaol1XqJ8lGt8qvFhW6ugeRrhCVEjfw5UZf2qSAAyzzHS9M2gGU9eJc2hAHqItgmag1NSjXDadzGPoLkRqukQt21MSGVpmGQ7nkzEVMHNiQvawqBoejMoDq+TaPg3r0K6QZG8w0J9nFRHW9AMOgBRRHPB3hd7NufKXB7ypVXJklOtN6GqoqybZC1gx+R1KgPfi9d2gL0SzPDwpowII++knbMZm16o/HYv/dRBsmXDeiFWAxYhi8tGKVyVvuxsIrVGG+y+yn2GH7iZiO5b4cdvd1XzES8zYi0+EeyjgNC+B1C0cjP0/Lt8zo5Bw2Ye7sviuzR25iUjel+XJdKGlQ5Or9bP6boEzouzXJMMMisIjAAMUABDL2FYHzfVpeInsFyNKqXW5aiFnOds/Ob9gJ9gJnp4voHT7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(6486002)(66946007)(91956017)(76116006)(107886003)(4744005)(8676002)(316002)(33656002)(110136005)(38100700001)(86362001)(66476007)(8936002)(44832011)(5660300002)(66556008)(2906002)(26005)(478600001)(186003)(71200400001)(2616005)(54906003)(6506007)(66446008)(83380400001)(64756008)(66574015)(4326008)(6512007)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QjdDZ09RUUhtQVl0bGhnUFZ6QzdicFc0VUdTcTBHOXZBdm4vR21wM05lcXZt?=
 =?utf-8?B?UGs1MWd6akZ5L2JOVURaVHp1enJNVzVSOUxJKzJyYXJtMWl0ZWtPZEJDTnVr?=
 =?utf-8?B?bHd5bDU5R294YWJhM0tJNFVjcVlZaTNzQ2lieFZLUFBiUG1BMjZFQWo4cE9u?=
 =?utf-8?B?TFRzUmNRYXQ3MGdBQ2NkZS9RL3hYTFVhTk41V0plMW9KdmQydHBiQzdkeUpr?=
 =?utf-8?B?MXQ0WkFhNGdISFFQNURpdVkrRFQzWHJxOWtVV3pwVFFqUkZQVFdqMTUyenNz?=
 =?utf-8?B?Q3RQU1k5TURoZEd6TUMzVW5EM2k4SHhwTmhvTVlaUkFrRDVFSXFTSlR5VGVw?=
 =?utf-8?B?WWFYdkRwbDFMUWVkb1JNSmwxQTdOU0RUWkE5L3BCaFNQNTI1QUVaZVV3bmFJ?=
 =?utf-8?B?VXp3VkhjNENYTURINHlNdGl5V3hLMUVSWDd4ekx1aUZTdFBTUG5UNG5pTHNG?=
 =?utf-8?B?K1kyUXhMZjJmeVlwL3JSOTl6VC9DeXRvNktBQUw0SStURmdDbXd0SEl5SWpD?=
 =?utf-8?B?QmNTQ0VGdnJzcUtkOEFMb2tGOFhNT24zVE5IRW5JaXNQWVlURk5PRWhseS9X?=
 =?utf-8?B?WlovNm9sQjlBVWVlYWxCS1lISHhhU3Z0L0g2bTdMbnpFSzl4VDJTYmJZb0F0?=
 =?utf-8?B?ZFczWFp4VzVnZ2ZxQUg5MERvbHJucDI2WHRoL2FxKzJNYjFmb3BkcEo2R1Ft?=
 =?utf-8?B?Z3pmWTNIUHBab1J4aytodHNoWHUxdlBBZ2d1aDdxbk56R2FiT0NqUFFzWGhK?=
 =?utf-8?B?cDFnZWc1RUxHbEp1UVFvVDdHeWdkRVVDUUczQVp3MDcycGd6SWZMWFQ4K1Fq?=
 =?utf-8?B?dmhyUXRUZmN3VVhLYk0ybjVVaDg2anNTaFB4ZzRhRmQzRFFHekdEblRCNkxS?=
 =?utf-8?B?ZFNNUUZVMzBEMy9GWEVOTmRYN3kxbEJZLytVdEkrZk92SFVrbmxNaWpDcUlZ?=
 =?utf-8?B?eGxpcUdlM1ZrMkNreXZDTlVhOGVHSTJZQUNqLzQ1SEZ1cGczMjVoUGlJenpB?=
 =?utf-8?B?MUMzMThZalhLU2xpcTBkTUhoWUNNbVdZQ2RPZlVROVcxcXlidjRrUk52cnkv?=
 =?utf-8?B?SHlIVkhSdU0vTGNjV1dQT2VWQzZMS0pDSnVmakJGZ2h0YitMclpVRCtXOUIz?=
 =?utf-8?B?VGVxTkJkcTNKMWlmSE12RVVWSnZORHZvb1lNN0ZqKzB0amUxSGdTSHo4WHhN?=
 =?utf-8?B?WkpVeWw2UXhubVowaXJxdS9LS0M2cGEwL3NIb1IyQlZ2T2tZazMvQ0MrdTZS?=
 =?utf-8?B?akF5VHVKWG1ySENPaURkWUJQSTM2cUhmVVN4S2orZllPTUc5K0xOSjAyeU9U?=
 =?utf-8?B?eUlzT2JDTVZuK2Q4K2YyZWZpdC9UdUx6YXRNL1hZTGZseHdCZ2pJdHU0NWla?=
 =?utf-8?B?eHllQmw3TUFuUUdnNXVtSHRYYUoxY3RORmw2djJ4ekg1NGhBV1p0bW5ESzJ6?=
 =?utf-8?B?ZWNDNGw1ank5d3ZTY0VldFdrQlZ4clVUR3NtMWRjRlplK1ZhdzErMHFtd2V1?=
 =?utf-8?B?ZjFNSVorUldmeGsvYzEyN3VrUk40TXcvbHpra202cCtEbFExMGpGNmtOQXcz?=
 =?utf-8?B?bmtldjkrd1RuS3lWN0x0Y0ZlcHdUQkxFQTZ4QnViRWgxOHRFbklMTDN5TUpI?=
 =?utf-8?B?aitESGgxN3Q4V1hUeUF0Zm1rbUtSRzFKT2FmWGZ3cmZwZHcxQktwWUpsUkZi?=
 =?utf-8?B?d3FpMnNzTEhNN3F1S1ZLYk5OSlRGeUZuRWdxTE5jNFlrWEU1V2w0TWNvN2x4?=
 =?utf-8?B?S0IwS1BCbWN0Ny9iZ0ExODhQbjQydkdFYXExaGNMdTBTdXdCdHpHenR1OHlZ?=
 =?utf-8?B?d0hac2g3Z0E1aTJPdUxKZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D6CF678585CB242A11B6B0FDB22C484@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42550f51-6c2d-4257-0f17-08d8f90ce2b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 15:01:41.0480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZN/YiXNB4WiTxjgx45BqGTQ6BR2zkelu96jK12ZtybcMPVBBlnOm20YrtWbn2rt4gf/2URd8blPY4xWNhlNwvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1253
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=882 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060103
X-Proofpoint-GUID: Ft71I-aYXvs3FodhwY96Ri1O6lJxkURC
X-Proofpoint-ORIG-GUID: Ft71I-aYXvs3FodhwY96Ri1O6lJxkURC
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 suspectscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060103
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

UnVubmluZyByZG1hX3NlcnZlciAoUkMgdHJhbnNwb3J0KSBvbiBhbiBJQiBkZXZpY2UgdGhhdCBz
dXBwb3J0cyBhYmlfdmVyIDQsIEkgc2VlIHR3byBpYl9tb2RpZnlfcXAoKSBjYWxscyB0byB0aGUg
SU5JVCBzdGF0ZSB3aXRoIG1hc2sgMHgzOSAoU1RBVEUsIEFDQ0VTU19GTEFHUywgUEtFWV9JTkRF
WCwgYW5kIFBPUlQpIGFuZCBvZiBjb3Vyc2UsIHN0YXRlID09IDEgKElCX1FQU19JTklUKS4NCg0K
UHJlc3VtYWJsZSwgZnJvbSB1Y21hX2luaXRfY29ubl9xcCgpLCB0aGVuIGFnYWluIGluIHVjbWFf
bW9kaWZ5X3FwX3J0cigpLg0KDQpTbGlwIG9mIHRoZSBrZXlib2FyZD8NCg0KDQoNClRoeHMsIEjD
pWtvbg0KDQoNCg0KDQoNCg==
