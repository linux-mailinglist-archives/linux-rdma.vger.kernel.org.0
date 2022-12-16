Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9730A64F22D
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Dec 2022 21:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiLPULn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Dec 2022 15:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiLPULl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Dec 2022 15:11:41 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906EC32B8D
        for <linux-rdma@vger.kernel.org>; Fri, 16 Dec 2022 12:11:39 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGJoWPH011305;
        Fri, 16 Dec 2022 20:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=c5X/pMdBJD2/s6x8s6OLBIQrrieC7Om3WfkykBRm/3I=;
 b=KBnm63r/GWzVFFirF2dDQFMvKUjI3pQMWZOkT7UCS5oJhWerOMi1PuvnVUcyVdqUPlqu
 C5mFzTiLV0o5GEF/Ok2nmhwyUGC6ZtPVb6omfQFWWUOumxNZHqrGRl0EMR0exSiaGOaa
 L4vaT8H7neGZDwpE8rfhKCs8LdCeiuIEhIxBlMWJIjnIumEKUx7Y8AVbdx5Ak1bj4B6c
 beNdotCyvGrAXh6+x1+VwZgVaexd4HKEogXUs07eczVlSu0U5BMDm/uS+0+nDlwP/wUp
 vvokNVKRktuKMqlaZfQbT+upnFqUdkmDNH1LMXmNr6mBWb+rT0phZe2zfARwYaunwhIz xQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mgy6gget6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 20:11:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QluuMIZIOXft1j1Bi6caQUrhJ5lYlWx9ltrSgnklNqrgXEka5mC8NJtgJ2vEgJLBpi1bp4pUEpxvSIyIknNzUaFpYd/K8hOrad6JJAARqfp2Zek9/s5dV/iCyeS2+vOr/Y8tTqiscwphKwwLlXD/MOuHbegSRqNutwavWL3yK5lU6LzMFRHSXTL/J0i80eVm9VFgMQigsdfVDFcjsNW0RE1EZLjcDIefw6Bl352vTD3UCVmR6byssazA8DcIVSXgVNAQi95+aysm3rOEncU8/KVG6dG4JVKNm2ZTWbH6Pmq29FM+nAuGv3UlpVRmw33Rp2gQ6rgYWQvoIRsWZnbN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5X/pMdBJD2/s6x8s6OLBIQrrieC7Om3WfkykBRm/3I=;
 b=eB2LdrOjOfSEJ5sZIwJ7ltLwf6zFC5HZkAGqOvYLjjhaZwyCRmnytj+g/RgYyEn7VgIQ4HZrhw7Te2uIGrxZtatltXdxg/nWFUbLIa6YmnDjUThgo5+z7F6M6+Mhome6wjbbuiR1mGNTN+Z2EVxPCXKRR3Q8jsWQf7yCFecZIqEjox4HP7lc1llzoKekLs4nsm2Ywrxa+tZFG/ISFwMJubJ/4QNxLkEpHfQE6/C4aAjS+BCozcoh2jNMXzhuEi/4WcZmglEcqlfsRKGmCMA97B/q0gW71YapmfNhSQRqBSpbj6SfaUE3Si2zSEkoZEAfyml4AKI4BOCPKjPICQAZbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by SA3PR15MB5679.namprd15.prod.outlook.com (2603:10b6:806:314::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 20:11:32 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d%5]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 20:11:32 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] RDMA/siw: Fix missing permission check in
 user buffer registration
Thread-Index: AQHZEXzAHvOYHC5AkUir3Kuzee3cEa5w1xuAgAAaR7A=
Date:   Fri, 16 Dec 2022 20:11:32 +0000
Message-ID: <SA0PR15MB3919045403A59EF36370173599E69@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <20221216183209.21183-1-bmt@zurich.ibm.com>
 <Y5y6OaG4+6kPt9O5@nvidia.com>
In-Reply-To: <Y5y6OaG4+6kPt9O5@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|SA3PR15MB5679:EE_
x-ms-office365-filtering-correlation-id: 11192850-51d4-4283-6d97-08dadfa1b9e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 92tU7qxrwk+yn3smvIYt7U3H46YxFgAWcRsVDc2rVAOWg3tZ7ZJIxOXRB2QbLXYQ+AH3ffw3npx0aOaBcZqXCbddwkuCHdXXjU0GPw7rHe8YDkcrWexq12koWJjEF5FtbisihPuCtYHJaZ6/qdk3yHc4/0G9ctvyYySOknzHoddTOq9vPsS4ecwlg6FxKLqCV0Y2wiGnpxlOu+Ty9nlQoGMEoPW2Hxn1otxFIOJ0aLLq4P6PqX6SXgBx5DNMLSgtu5WL5n0i0RpDrq41174nb62JNttXjr0O0ZfIr/RHstpMRxwr+CSx15H8xVI28TfaH1ZHnV6ba8gedoi/nFSfSV5yXCHChHqA0GKZnkiTizKGGrizuHKVi0KdarueaAhnestJyueielV81t88WX0HAsWFS5pmdPCQEXPLBNOpAGBb7FCHGN7AWMB8xOPyB19Aev9oYZ0GB8GG3ctWQu+q7nP5iE4yQWNgmZmsT28tZs6elXdwhTon+mQcQ0KHxlKh16fS2gKT51nEGzj2iShz3CtSVU5tARNsDmsTOlCPCOGblugOw+/oiQuyQbaYIl2yYt1vpG22TEpcsRnbmzZXJGt5BdkAMAcn9Ve5j+3tkV4JkdaEHBOF8QjmGQrvfbsj4J+y+Ngj58byalmXRyv/We37DWlqW3NXCEVuUIu7otpLWM81v12v4EWcFyV0TcdqvYohOyF7MZyyoh8JidS1ZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199015)(2906002)(66556008)(76116006)(66946007)(66476007)(8676002)(66446008)(5660300002)(38100700002)(4326008)(8936002)(83380400001)(122000001)(33656002)(86362001)(64756008)(6916009)(316002)(54906003)(478600001)(71200400001)(38070700005)(55016003)(52536014)(41300700001)(7696005)(53546011)(9686003)(6506007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UW02VjhrWlNOWDAvSWRZUHZEc2FqWmZiUThxVjViQUt5TTZ4K0RBdGo3M1lZ?=
 =?utf-8?B?NnYzcGxhbUtzUmRuYTFoS3BSMC8wVTJOdmkzSU5hbE9JeXd2emNSR2ZjNllZ?=
 =?utf-8?B?ZC9NdHFhOUtnb2hCT0NlTjlQK2luSU9RZTFiTjBxNGlVU3BmcVNxTkE1N2JZ?=
 =?utf-8?B?dTJqUE52SnY4czBtNkRhRHQ5Z2w1dEJNWVNtbElHRGF5dDJWYTFNZGF1RDFN?=
 =?utf-8?B?WjlNS3ArWXpZMzl2enFYRFN0MkZSMnl3QlNScXU5S3ByRFkyWlF1bHAzTHRt?=
 =?utf-8?B?MlRWYTZybHJrMCs5Z3BxRDg1UGVueFFqN09FMXB3UHF3eVgvajEyOGYvNmg5?=
 =?utf-8?B?dk5RcXBhdG80OGFLNlJkU01qdXRDMUtyL3F0OUtpb0Z6UzErNFlmc1lRQWNk?=
 =?utf-8?B?Zjk3MTJyV0dpTUpMUHJzSEpad1lrazUwaHpBaGtVa3UwYnVENmNwcGwxeklm?=
 =?utf-8?B?TXplRWNOU2tzWWkwY2VwVUUvelBCK1BHTTlGb2NKbG8yRkNmNU42d2locTZs?=
 =?utf-8?B?K0xuMFFhaDdTQkUxYUhWRHNBa1Z2Vk5XaE9GdUZmQVN4eVpINlY2ZDlycTBS?=
 =?utf-8?B?Zkd3T1RuNXdOc3M3Q3VtWGNldzZHeUlTNFpWUmViRzVURmVhNTVxYkFRWlUw?=
 =?utf-8?B?MldrdTlud0lHclVXdU84NFJiL0Fod0hjNTZRenZhaFBCVkRWa2YvL0o1TmR6?=
 =?utf-8?B?UTQxbWRWN1U2RFQ2TWtQSStRWTJuelhlTUxjU2VnMFdJcDQzcU5naktKSzhx?=
 =?utf-8?B?U2xKeWI3MUVydnE3YUh2SUgxRlFtV0hPcGg4OVVDU1BJR3hQMVdidHBFRE85?=
 =?utf-8?B?Wk9BeStnRWx2Wk1tdm1GTURIOTNtRjRzRkZvbWRtcURNcUtucm4yQWwrTFVp?=
 =?utf-8?B?T2VTOE1JNW13eEt2Z3EyZjYvRTFHSFFyQ1hQbUsreXdLT2VyNDhobmI1U0tO?=
 =?utf-8?B?TEpTNHcrb1M1bVFRUmdMbDdHOGpzNmlxUGpjUzV0Mm9STTFpWFh5Wm81aHRD?=
 =?utf-8?B?R2RaVFZGczBUUFhkem9ZZ3NhRzRLdk1Zd0dDWkF2clFZWUxka1I4MUc2SFF6?=
 =?utf-8?B?VW1SNHgzOWEyY0xveXh2bUFqY0VzNVZZdHFpNDEwVFZHaFdPeXNoZnlRb0tN?=
 =?utf-8?B?VDBGV0xUOXhLUFJNcmhzSnJTRkFpZVA4Znlzd0RhQnhnMkd0dGpyeHNCVnlp?=
 =?utf-8?B?S0pBYVZ4a3JVbisyazZrZGs2UXRMd3VFbmJaMC9sU3E1L3ZMbU9RVzdCTm91?=
 =?utf-8?B?RzhPYmw1OWtDd1ZhV205c1N5SmwwRUdTRVZuK1hhend2aHVKMWhkWkxrUzlW?=
 =?utf-8?B?bjNmc2k3cWdXeFhjWURWdTdKZ0JneHpnZk5QZ2g5TjlVSFQ2a21UU3Z6MGFy?=
 =?utf-8?B?VERyVm9RSmNvNlo2LzRDQVdyYUs4aEk1MmlKTGNwY2ZFaWZTSHl6alhydDZw?=
 =?utf-8?B?OXNNbitzL1NNcDBONk1VZ1FVT3lzY0tKV0QzOE42TkNnL1JmSmJQeUdBckc1?=
 =?utf-8?B?MGpNZ2F2VmZBUDNpZVVrQldTVnZ4QzJ3ZzE4SDNXdDRENWZLQXhQRHJ1MGVR?=
 =?utf-8?B?cWEvWEY2Nk9nMi8vN3ZkYWlXblRtY2duckJQOUVyOXJKWjNLZGd5VnBvbTBp?=
 =?utf-8?B?V2hJNWhUd2hzazFNdktIRWhHMUhITmVnd2FCU2dCYmRRVnoyV3pNWjVNa1g0?=
 =?utf-8?B?RzhlV3VscDY5a0pRUjR2anVKL1BST3doK3dMeFVsVTVwYmJrNFR1Sm5XYVpx?=
 =?utf-8?B?Qm91ZXk3bkpCbWxuSDJKTzc3Sm1NOGtOQWNhN1hoYThGVXZmZEZZVTZoWVFa?=
 =?utf-8?B?YXExZlhFNEwwaFA5NmtIZC9GSjZsajlwajVOSXVPVDQyMDRTc0h3cGFBUzhL?=
 =?utf-8?B?MmordFg4OWlsM09mM2E2QnFzMmNGbVZKcFNNVlhLQjV2UVRCN2pZUUx2MGlQ?=
 =?utf-8?B?TlFrUlpmVlI5WDJuQ0JUOW9EVFFlZHJGb2NPakt1cWdScklwQTF1dWpCTFgz?=
 =?utf-8?B?dkkrdE8xOEFBZUlNYXdNd0NweEcrQ041UzdpMGZsMkVRbVAzYU1GbGdwdjZt?=
 =?utf-8?B?Z0hsa3crOE51MmdOUUtwcjN0SlMvWEZEcHB0RSt2amtsOG5oKzh0SzhCTGs4?=
 =?utf-8?B?Tm5nWU1QYno0bEVCZWJTa2dsOTBUMkowK0dXYndRcUxHbS9oVFZqNnZ3UjFi?=
 =?utf-8?Q?iGAB2/FDa/TxDMNd4Ngq/kOgsiz2G3pDIpqhLfZK2Atf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11192850-51d4-4283-6d97-08dadfa1b9e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 20:11:32.7714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zj11OzD3sJRtXJWGBJCblKSGYV1o8pymsJv6sm5X3mObw/yvekHfVaiw0C8SoWwzPLtD601nn2OaQAmSidu+AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB5679
X-Proofpoint-ORIG-GUID: Z6TZQgigqpIRO3x7Fu5lCvouYPIswmgs
X-Proofpoint-GUID: Z6TZQgigqpIRO3x7Fu5lCvouYPIswmgs
Subject: RE: [PATCH] RDMA/siw: Fix missing permission check in user buffer
 registration
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_13,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxscore=0 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0
 mlxlogscore=836 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212160177
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gR3VudGhvcnBl
IDxqZ2dAbnZpZGlhLmNvbT4NCj4gU2VudDogRnJpZGF5LCAxNiBEZWNlbWJlciAyMDIyIDE5OjM1
DQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT4NCj4gQ2M6IGxpbnV4
LXJkbWFAdmdlci5rZXJuZWwub3JnOyBsZW9ucm9AbnZpZGlhLmNvbTsgRGF2aWQuTGFpZ2h0QGFj
dWxhYi5jb20NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENIXSBSRE1BL3NpdzogRml4
IG1pc3NpbmcgcGVybWlzc2lvbiBjaGVjayBpbg0KPiB1c2VyIGJ1ZmZlciByZWdpc3RyYXRpb24N
Cj4gDQo+IE9uIEZyaSwgRGVjIDE2LCAyMDIyIGF0IDA3OjMyOjA5UE0gKzAxMDAsIEJlcm5hcmQg
TWV0emxlciB3cm90ZToNCj4gPiBVc2VyIGNvbW11bmljYXRpb24gYnVmZmVyIHJlZ2lzdHJhdGlv
biBsYWNrcyBjaGVjayBvZiBhY2Nlc3MNCj4gPiByaWdodHMgZm9yIHByb3ZpZGVkIGFkZHJlc3Mg
cmFuZ2UuIFVzaW5nIHBpbl91c2VyX3BhZ2VzX2Zhc3QoKQ0KPiA+IGluc3RlYWQgb2YgcGluX3Vz
ZXJfcGFnZXMoKSBkdXJpbmcgdXNlciBwYWdlIHBpbm5pbmcgaW1wbGljaXRlbHkNCj4gPiBpbnRy
b2R1Y2VzIHRoZSBuZWNlc3NhcnkgY2hlY2suIEl0IGZ1cnRoZXJtb3JlIHRyaWVzIHRvIGF2b2lk
DQo+ID4gZ3JhYmJpbmcgdGhlIG1tYXBfcmVhZF9sb2NrLg0KPiANCj4gSHVoPyBXaGF0IGFjY2Vz
cyBjaGVjaz8NCj4gDQoNCiAgICAgICAgaWYgKHVubGlrZWx5KCFhY2Nlc3Nfb2soKHZvaWQgX191
c2VyICopc3RhcnQsIGxlbikpKQ0KICAgICAgICAgICAgICAgIHJldHVybiAtRUZBVUxUOw0KDQpT
ZWVtcyBJIGhhdmUgdG8gd29yayBvbiB0aGUgY29tbWl0IG1lc3NhZ2Ug8J+YiQ0KDQoNCnBpbl91
c2VyX3BhZ2VzX2Zhc3QoKSAtPiBpbnRlcm5hbF9nZXRfdXNlcl9wYWdlc19mYXN0KCkgLT4gYWNj
ZXNzX29rKCkNCg0KDQpzaXcgbmVlZHMgdG8gY2FsbCBhY2Nlc3Nfb2soKSBkdXJpbmcgdXNlciBi
dWZmZXIgcmVnaXN0cmF0aW9uLg0KV2hpY2ggaXMgZG9uZSBieSBwaW5fdXNlcl9wYWdlc19mYXN0
KCksIGJ1dCBub3QgYnkgcGluX3VzZXJfcGFnZXMoKQ0KDQoNCg0K
