Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F17736B6C
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 13:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjFTLxo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 07:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjFTLxn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 07:53:43 -0400
X-Greylist: delayed 2624 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Jun 2023 04:53:41 PDT
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E9018C
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 04:53:41 -0700 (PDT)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KB0k5p021895;
        Tue, 20 Jun 2023 04:09:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=PaIaAwa/sh/YVv1S1xYOx8iY38b9fyPMpT4mR3zi0Tk=;
 b=HxMBYArOYBX85AUDO5T52qOqX9vPpXn4JIsb/+VqWtEKBbRDXCoMzbW2SFg9ApGl+l1c
 rz7r1W380QsF4TOIMQwjlkCNA8fal/15Mpcd0eyepfcKSIsybXWKH62Bh9RweEzxv+Qe
 d5cg19seYo5ZqfWn9qRpq7AdgBk8m95r564bbeAvrT8jR1PYagT4E6s1UKrpAalxq92c
 R7FCOCCvRLvcaFPwubqFbQE+u2MIZ7L3x134rRf8SHtWzvYOI/Q0ccgaBRFjSSo4OfgB
 CrKvpyVKtvC4N1aMbcSQpXyYwp+1Xl6hJHat/ceusWnKZ2cvPIEKugc8rB4ijWI7qZOu 3A== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3r99cwsd39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 04:09:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYDS8+sdYp4XVZ0dbuIoyml3yag+nvsbopuToUvwP5dF0R/cOak4go77Vl9t5GlIgFFsbvilbO9PElbDvitfML7vBtvxVu01OZ/iN7z7Hv/+0f072VzoZTbSiSVkEDdvOPWAZDJO0PtpF7JGrbV6GTBBhTXb18a39Y20/vyUCykZx6prgvaPloNo1M1BeJ+mxdYeZltEI+b7PoKbrn2Zn0k47A5S6rTA/A9rUrkt1GoRKdXtcSIr6dKxN8yn2+c90N2Oe6wZWgikIlpSfCNYDPl5A46772cDGmwizV01KnLiAu6S9kTtvp0UnNQOa0HEd5FwycWcLIg6GyrZSBSTkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaIaAwa/sh/YVv1S1xYOx8iY38b9fyPMpT4mR3zi0Tk=;
 b=BdcgK2A+6F7usb+FnPNnqkyx6s1jZQCRJL05jQnnwvNKuTm/PrzleGY2MYpxFys9qdIr3lIK1I1zW4APSiYNqo1h7CpMIaOqGwAxCpdWYvtbhkouBTzizwlvFP4vJbLdO7umOM9kWUM56N9paCYCohDr/9QHEXj/lWZPuAtVqc9mPTuXgcpvkiBd3Xqeue0oHRwomKpTrpcMmsSA+Nqglq3LdJnCLPHG9gl8LrS6fUiHBj2nvZGs/Z3mEMVmOshPMqITtuY06IwRO7ZGN/i9gSkxV+nV8rjbfE2ATtpU+JDyLz54uhxinixQFg8xP+jfn3VL2m58rgV2rMpH192K9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaIaAwa/sh/YVv1S1xYOx8iY38b9fyPMpT4mR3zi0Tk=;
 b=RA2DI4kU8LVe58ABvCGWWCl6pYR/I0BA/hTN01GYgkk9vD+5RALtHD8VN7AOIezXOnhg1Zr8MN0tUaGQ7nzIFvUr1VyvqZYM3cLLPXhxq0YakHRyW2ny/jZzWEk1gkLmYi+lvQEkI2oX3zd8LW2J75fyHVAwE1SpGBK2yNfik5c=
Received: from SN4PR07MB9264.namprd07.prod.outlook.com (2603:10b6:806:214::13)
 by SN4PR07MB9295.namprd07.prod.outlook.com (2603:10b6:806:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Tue, 20 Jun
 2023 11:09:43 +0000
Received: from SN4PR07MB9264.namprd07.prod.outlook.com
 ([fe80::c4c5:c38c:f3ec:90b8]) by SN4PR07MB9264.namprd07.prod.outlook.com
 ([fe80::c4c5:c38c:f3ec:90b8%3]) with mapi id 15.20.6455.030; Tue, 20 Jun 2023
 11:09:43 +0000
From:   Rogerio de Souza Moraes <rogerio@cadence.com>
To:     Daniel Vacek <neelx@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leon@kernel.org>
Subject: RE: [PATCH v2] verbs: fix compilation warning with C++20
Thread-Topic: [PATCH v2] verbs: fix compilation warning with C++20
Thread-Index: AQHZnfnYRq8XAPxUlEuN37b7Dy7sMa+TdLUAgAAeeyA=
Date:   Tue, 20 Jun 2023 11:09:43 +0000
Message-ID: <SN4PR07MB9264367CA70FFA6EE79248ADB55CA@SN4PR07MB9264.namprd07.prod.outlook.com>
References: <20230609153147.667674-1-neelx@redhat.com>
 <20230613131931.738436-1-neelx@redhat.com>
 <CACjP9X_ONQR53Js301r1WGguMR4hhtDZRkoMJjUMDqX-=yA+1g@mail.gmail.com>
In-Reply-To: <CACjP9X_ONQR53Js301r1WGguMR4hhtDZRkoMJjUMDqX-=yA+1g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccm9nZXJpb1xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWY0MTU1MzExLTBmNWEtMTFlZS1iYjRmLTljMjk3NmFjMDJhZlxhbWUtdGVzdFxmNDE1NTMxMy0wZjVhLTExZWUtYmI0Zi05YzI5NzZhYzAyYWZib2R5LnR4dCIgc3o9IjU1MTYiIHQ9IjEzMzMxNzMyOTgyMTcxMDgwNSIgaD0icG5pVWJ4bnlNckR6SnBDV0lPZXBQWXgwVU53PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR07MB9264:EE_|SN4PR07MB9295:EE_
x-ms-office365-filtering-correlation-id: f3556f34-af30-4851-7969-08db717ed9c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KGcKFjP/YXHzU9rUNOeQ/VMyMtzkLR/oFeiSgq9+F/tcyZR2e7l5JXySFloTm34wuBEcOo/SjEpB9bh1Uaf3AaBra6e32iKea51SdesvhCdrzBAkuWUmK+37GqfxBSRqSJEU8DiGrF4EVkhvEH6EAEZw0+bbuv7X2vjTbV8BEzsUHmz9ECnQq+lujne+xRi0U4xz6Znwaplt+07O+BiUL1PmsqgvayONj6deqqm+mY/Y/F8MxtF9kiWT6WijgerenTGTT9RP1lxoZ+3wWTbtpX2yoD3L5dDsFHRE4Tytd43BrrdixIG29qvVJ1/fa8KlDjwyMnO6hWIO6E0YBKD1pJbYg/vf+/Jm3FemkeZ+7Mb/VOfS8Sss4CdMyJDKHxh1TdrtLP03R6RCGCgJb4KklZb9VXrtFTk/G6i97BPCz5xCwDbcjSxTc4MkcVZgYcfm8fVDg01nmS03GB+gzhSL5OJuqajflT458YbX/emvB4KZiQnzaOJdT4uniVjcjpxFSDOWBYyIKTbuIYFAs5jvRs7r3g4NzGSVAvUlRk/sov8LBo2+8go2AkYO+M4mQgRWargFYJNJQM5xTnET8ozQiOdXA9fINEboo3r0dl1lrIsrV9KpqvM+Ly/gjoied+N+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR07MB9264.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(36092001)(451199021)(7696005)(71200400001)(66946007)(122000001)(2906002)(66556008)(76116006)(41300700001)(66476007)(64756008)(66446008)(33656002)(110136005)(38070700005)(38100700002)(5660300002)(8676002)(4326008)(52536014)(316002)(86362001)(55016003)(478600001)(8936002)(6506007)(9686003)(53546011)(26005)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHhQaDJrR2NtUTh0bWh1M3Y3TVBpUmE1T1g3ZjczTjZhWmROUkZ1TzUyQk5F?=
 =?utf-8?B?ODVkMSs5UFJZSWx5QXIzbjRBRFhqRi9ZbUdjRG1UMUdnOU1PU09PbFZxTVBU?=
 =?utf-8?B?Vlh2VDY3YURaZ3dNaHllL0J1blJlWTRGK1ErUHRFYjE4c3lCbXlESVlscnlH?=
 =?utf-8?B?bGFXQWxSZnRKU3A5UDI3MlVMMWx5RUdqalNWdnZtOGk5SU5OVld3d2lUQ2th?=
 =?utf-8?B?UCs3QnQxSUlieWc0dHdoQTMxY2krOGNEY25KQ1YrM2FZb2gyb3ZrTjlUV1JZ?=
 =?utf-8?B?dk51aHBJNFRZRmdvY2V6eE4vaHhkT1ZvaWRNczIvamNHRWZJRFZ6aWd5ODFt?=
 =?utf-8?B?VlYxVWc5SnlkcHMwVFJXaURWUkhUaVAzbWRhM3BoYjZmTzd1a1o2L2NxaWk0?=
 =?utf-8?B?Z2V0bk1Namt0Zk1zbXBJKzd4N1MvQkM3dkVtM0YyaTZmQVNRM0krQUxGaUR4?=
 =?utf-8?B?QXFkYUVVZTM5SHlST1E2dGp4NU9JZTlYWHViZzZuUTFUUjBiQVoxV01SS0Vm?=
 =?utf-8?B?TEI4VUJ6M2orZXNWV1diQmdPSjlyUVY3eEMvaVBKZzcwZnV6UG5IUlhIck1R?=
 =?utf-8?B?V2tNODVjRWFrSXFGYkpJaDNzeGVlYVhyM1h5a3FYWnZ1MW9WVUw0SVNLeDRK?=
 =?utf-8?B?R0NaWXZzS2ozWXQ4V0lUWTg4REt3UTVLVy9LbTNjejNwMm0yWXJ0bDJhNEoy?=
 =?utf-8?B?SWo5YlpMTkNweEY1Vmhwak1FNVN5VmprVkNleW1GSXQwUU1PbEdHc3hJMGEy?=
 =?utf-8?B?MEw1MmE2STNYMmx6Y0FKQkZhcklKK3hWb0ExTzZha0QwcW4rRDl6eVh5VmxO?=
 =?utf-8?B?NFljeUQrMVprejVKWGJNVWFXaTFYM2Z0ZkJPRGd0VGpYaUNjRXcvUWZFSFNT?=
 =?utf-8?B?ckJyOEN0VjRpaFZ4OWpDUit5SkVZbFplT2xab0svSmFZMkQ0OVIxVkNQSlF2?=
 =?utf-8?B?djhtQ1hBZVJNVWE5SzJZZ2M1S0lDYW9ySHovazV4Y29hdjdCZTdrMjlhK3pl?=
 =?utf-8?B?QThSVWFhamFRQk5OUlhYNzZsNkU3aDQ1TElEb1QvVzYxc2o0eFg0elVqY1Iv?=
 =?utf-8?B?bG9TVThNaGo4OGl4TWNVTnUxcXprZXM0aEFEczF3V25vVHRWaFo5RE9vY3R2?=
 =?utf-8?B?QnN3enVrZ1hOMlhkejBRNW9aaDA0L0NVZ0cweDFxclVKVEhjSlhNUmFtU2o5?=
 =?utf-8?B?ZzJ4T0VCenFYQlVCMlB6STJXR0ovWVh6eXlaOXY0VzBTVHQySG9RaFlva0F5?=
 =?utf-8?B?MDFudHlBNFVGbWFNM3VudDJnLzBHaEF3bXdNZDRRYVBNRUQ5N2lMeC9KUERR?=
 =?utf-8?B?YmhSUTFqOTZIVFB1QTg3NXNnZktUKy9VM05zNWZNWEs4SzJqenpVTG9va0xL?=
 =?utf-8?B?TVk4MGhxODQrWENzczBVTGd4UE51UXNDUHYwZGR5WW1xWVZSeWpmYWJVYXR0?=
 =?utf-8?B?dWZQbVhkYWtGNHpxdUpIOVYrUS95UnFtek5vRndiWU8yUTMzaDFsS2owZ2FI?=
 =?utf-8?B?S3ZYbFRSN1JGT01YYUErb3FrV21rYStsSW5CZDFiN1M3MG5lR3lUejdvWGJ2?=
 =?utf-8?B?S1djYTVmZit5dVk5V2lNWWV3UnBHSm42TUtRZll3VlJGdU02TmJDOUpHNkRj?=
 =?utf-8?B?VEc2VnUraFhldTIrSVM2VXpENExtUXdDNDlLUDRRc0Z3eWpkem90VVdscDNw?=
 =?utf-8?B?TVUrRFlvanluQzRQRTc2aFMyQUVsZU16ZGpjVHNUNW8vcWR1c085VVRlSGdJ?=
 =?utf-8?B?UFpGM1JFOHdoK0hmWVJwS2RaaXNqTzIxRDNieHNuc0tWKzQrU2toMkF0SXBC?=
 =?utf-8?B?RDA2VjArL3ZPYm4vK1crSmk3b1cwVG5ZbFZwV1hnSGg5RHhoTUxuVEtXVkdJ?=
 =?utf-8?B?T0tNb1Nhdjc5aHhWc3k3b3BONDJ4OE1yVThmc2RGT3d0ZXFQaE5SWGNxNzBp?=
 =?utf-8?B?RlcvWGN2dXMwc3Y1Tk53MWhKVkFvRWYzZ3B4M2NYb0pEc0xOdjdxTXEyNXh2?=
 =?utf-8?B?d1JnaUNvT3pWVWdlUVpwT3JwMEpEcTRXZDNSZG5RVSt1L2k3UWViUTIrSFhN?=
 =?utf-8?B?bnRxWDRnL0EyNU05dFN1YUlESEZlbHQreWJaTG9ENmk0TTkrR0ZvdFk0UU9n?=
 =?utf-8?B?RXRJc1d3Q1ZyOEIvTGdWc1JDUHhzQlFzUERxYm80MnhHbDRIc0RyQm5XTWRu?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR07MB9264.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3556f34-af30-4851-7969-08db717ed9c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 11:09:43.6204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M7roaHsAYLyv2344soSnBNNs5CNF29g1D2J200l82Yenp9ijHj7wykjR3EyVXcJg8WLRcZdfmOy8wddAaF7hXrdc+8yRYXOwOXUXgjBmoLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR07MB9295
X-Proofpoint-ORIG-GUID: aXPN5VC9gZ_d9yGrwkcYikKGHw1jKJCF
X-Proofpoint-GUID: aXPN5VC9gZ_d9yGrwkcYikKGHw1jKJCF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_07,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 mlxscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 phishscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200100
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgRXVnZW5lLA0KDQpSZWQgSGF0IHByb3ZpZGVkIGFub3RoZXIgZml4LCBjb3VsZCB5b3UgdHJ5
IHRvIHJlcHJvZHVjZSB0aGUgaXNzdWUgb24gbXkgbWFjaGluZSAoc2pjdmwxLXJvZ2VyaW8pIGFu
ZCBnaXZlIG1lIGZlZWRiYWNrPw0KDQpSZWdhcmRzLA0KUm9nZXJpbw0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogRGFuaWVsIFZhY2VrIDxuZWVseEByZWRoYXQuY29tPiANClNl
bnQ6IFR1ZXNkYXksIEp1bmUgMjAsIDIwMjMgNjoyMCBBTQ0KVG86IGxpbnV4LXJkbWFAdmdlci5r
ZXJuZWwub3JnOyBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT4NCkNjOiBMZW9uIFJvbWFu
b3Zza3kgPGxlb25Aa2VybmVsLm9yZz47IFJvZ2VyaW8gZGUgU291emEgTW9yYWVzIDxyb2dlcmlv
QGNhZGVuY2UuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gdmVyYnM6IGZpeCBjb21waWxh
dGlvbiB3YXJuaW5nIHdpdGggQysrMjANCg0KRVhURVJOQUwgTUFJTA0KDQoNCkFkZGluZyBDQzog
SmFzb24NCg0KLS1uWA0KDQpPbiBUdWUsIEp1biAxMywgMjAyMyBhdCAzOjIw4oCvUE0gRGFuaWVs
IFZhY2VrIDxuZWVseEByZWRoYXQuY29tPiB3cm90ZToNCj4NCj4gT3VyIGN1c3RvbWVyIHJlcG9y
dGVkIHRoZSBiZWxvdyB3YXJuaW5nIHdoZSB1c2luZyBDbGFuZyB2MTYuMC40IGFuZCANCj4gQysr
MjAsIG9uIGEgY29kZSB0aGF0IGluY2x1ZGVzIHRoZSBoZWFkZXIgIi91c3IvaW5jbHVkZS9pbmZp
bmliYW5kL3ZlcmJzLmgiOg0KPg0KPiBlcnJvcjogYml0d2lzZSBvcGVyYXRpb24gYmV0d2VlbiBk
aWZmZXJlbnQgZW51bWVyYXRpb24gdHlwZXMgDQo+ICgnaWJ2X2FjY2Vzc19mbGFncycgYW5kDQo+
ICdpYl91dmVyYnNfYWNjZXNzX2ZsYWdzJykgaXMgZGVwcmVjYXRlZCBbLVdlcnJvciwtV2RlcHJl
Y2F0ZWQtZW51bS1lbnVtLWNvbnZlcnNpb25dDQo+ICAgICAgICAgICAgICAgICBtZW0tPm1yID0g
aWJ2X3JlZ19tcihkZXYtPnBkLCAodm9pZCopc3RhcnQsIGxlbiwgSUJWX0FDQ0VTU19MT0NBTF9X
UklURSk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgDQo+IF5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+IC91c3IvaW5j
bHVkZS9pbmZpbmliYW5kL3ZlcmJzLmg6MjUxNDoxOTogbm90ZTogZXhwYW5kZWQgZnJvbSBtYWNy
byAnaWJ2X3JlZ19tcicNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoKGFjY2Vzcykg
JiBJQlZfQUNDRVNTX09QVElPTkFMX1JBTkdFKSA9PSAwKSkNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfn5+fn5+fn4gXiB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+IDEgZXJy
b3IgZ2VuZXJhdGVkLg0KPg0KPiBBY2NvcmRpbmcgdG8gdGhlIGFydGljbGUgIkNsYW5nIDExIHdh
cm5pbmc6IEJpdHdpc2Ugb3BlcmF0aW9uIGJldHdlZW4gDQo+IGRpZmZlcmVudCBlbnVtZXJhdGlv
biB0eXBlcyBpcyBkZXByZWNhdGVkIjoNCj4NCj4gQysrMjAncyBQMTEyMFIwIGRlcHJlY2F0ZWQg
Yml0d2lzZSBvcGVyYXRpb25zIGJldHdlZW4gZGlmZmVyZW50IGVudW1zLiANCj4gQysrU3VjaCBj
b2RlIGlzDQo+IGxpa2VseSB0byBiZWNvbWUgaWxsLWZvcm1lZCBpbiBDKysyMy4gQ2xhbmcgMTEg
d2FybnMgYWJvdXQgc3VjaCBjYXNlcy4gSXQgc2hvdWxkIGJlIGZpeGVkLg0KPg0KPiBSZXBvcnRl
ZC1ieTogUm9nZXJpbyBNb3JhZXMgPHJvZ2VyaW9AY2FkZW5jZS5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IERhbmllbCBWYWNlayA8bmVlbHhAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICBsaWJpYnZlcmJz
L3ZlcmJzLmggfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2xpYmlidmVyYnMvdmVyYnMuaCBiL2xpYmlidmVy
YnMvdmVyYnMuaCBpbmRleCANCj4gMDNhN2EyYTcuLmVkOWFlZDIxIDEwMDY0NA0KPiAtLS0gYS9s
aWJpYnZlcmJzL3ZlcmJzLmgNCj4gKysrIGIvbGliaWJ2ZXJicy92ZXJicy5oDQo+IEBAIC0yNTkw
LDcgKzI1OTAsNyBAQCBfX2lidl9yZWdfbXIoc3RydWN0IGlidl9wZCAqcGQsIHZvaWQgKmFkZHIs
IHNpemVfdCBsZW5ndGgsIHVuc2lnbmVkIGludCBhY2Nlc3MsDQo+ICAjZGVmaW5lIGlidl9yZWdf
bXIocGQsIGFkZHIsIGxlbmd0aCwgYWNjZXNzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXA0KPiAgICAgICAgIF9faWJ2X3JlZ19tcihwZCwgYWRkciwgbGVuZ3RoLCBhY2Nlc3Ms
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiAgICAgICAgICAgICAgICAgICAg
ICBfX2J1aWx0aW5fY29uc3RhbnRfcCggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICgoYWNjZXNzKSAmIElCVl9BQ0NF
U1NfT1BUSU9OQUxfUkFOR0UpID09IDApKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICgoaW50KShhY2Nlc3MpICYgDQo+ICsgSUJWX0FDQ0VTU19PUFRJT05BTF9SQU5HRSkgPT0gMCkp
DQo+DQo+ICAvKioNCj4gICAqIGlidl9yZWdfbXJfaW92YSAtIFJlZ2lzdGVyIGEgbWVtb3J5IHJl
Z2lvbiB3aXRoIGEgdmlydHVhbCBvZmZzZXQNCj4gLS0NCj4gMi40MC4xDQo+DQoNCg==
