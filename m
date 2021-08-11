Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D106F3E8FD4
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Aug 2021 13:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhHKLvP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Aug 2021 07:51:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60614 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231193AbhHKLvO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Aug 2021 07:51:14 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17BBkWVA030112;
        Wed, 11 Aug 2021 11:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2fKlKYeebcd7suqRpHMaupqRDUS7ZBfKGX+d6H3pzqI=;
 b=WfJB/WXzIh/7PqwFJUGHrAZstLcGSeSphtomXQf4K51CsFvCMj9doRAKtY7MWhhHnISw
 42USoxpkOT36D07fmj3BxsevcSouFXZiiytIhkdMZPJ+/4ENMA56QKr6jmo/g4mXHHac
 SuGHxLV2u+1KvDnE9Cz12e81KgrFgCBEDkPWg/vsEhL6UMNf0Aqho7GV2oqH/SrFc/lc
 lwYIHxRXBUApQPXv6dfGY3wF6BX85c4ipKsjBJnbZsEDV68HI+lS5w7Be/c5/0JFPAYD
 j/KE8eqciah9BjUzca8abiDSTrohB1AUryx66dKcC0c1WFyvPD9eILEJrqyytLA5IY9S ww== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=2fKlKYeebcd7suqRpHMaupqRDUS7ZBfKGX+d6H3pzqI=;
 b=OXDxjhX7Fd0JqPlwKtSJagkuiDQcedmuO1c/iNuulNE+Gi98FlLBTZNg9HChI5+3XTAq
 r8G7kI+iyRqWlqUCuc5J012L+EE5JQl6KjWxnNEwu1duMpCietUWdqg4GEz7SVEAz6dO
 heJ+z/2DCv4yl9Zg16785fkVTCOpUHFDUdM0Up6gPxgaIEsjnKG/SI4SALbNmZdp48mY
 OcO5WLY278julB9luy202hxqiDTT5nT+k3jxMQZaNotiqSHeA3YfYYIyhRnzZ2MkOgjj
 F66gElSbtD9LCF9XFIc3OoWBBPp4cF77csBhPXwAEqc/QR7g+r2PMh7U2olo5ewxm8iQ 3g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abt44afej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 11:50:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17BBoI7Y044737;
        Wed, 11 Aug 2021 11:50:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3020.oracle.com with ESMTP id 3aa3xuxux5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 11:50:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZPH1RHNVr/mJq1VAxLK1XhLieh3/jGFPnVW4VUJnXpOXWCS0f/+/YGaC/r1fhRNPqFcxNJP78RWasqlw1sas2jHUdSQGFCG59cveernemzXxGFurIA1FMLEvqXNTidq+V6YIxUBCNDoya2WtHTwS3LnfBltBsa+JEzS+d1gx7taGv3+6bneaEaGZBURDvEIwSVVLZxQ1TLAbsU9ub70LC6CPXQey0n1OYl3wttGB+UgQRdCB5cAMvBMNTDybLxPIdmvCSvtbMexpgc95/ILEsTyn0zJDUJyxw/RTiGfRedSqLLJN8fyy0PQ/L1uF8ywHWD26akh0UdsHzMpzxr9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fKlKYeebcd7suqRpHMaupqRDUS7ZBfKGX+d6H3pzqI=;
 b=H/L3a6C4FLtbboHKeE6yBeIxIPMShu9R2QHONxsqVAUYNDPGP2DY8QO7rZEPhBnYA7HNpddGBq86gSO+BU3SAXQNyRdKuTQOJCqbR88dJgc/r8vbqs36TiQOWcPNf2zg1+iUZluj4GiuXQQR9NFPoz1oiWD8b17mmAdtORPsbSDLhUHkaWIO8a/BjXt05qSQzahpRwQjRdjgqx36Gxsbo+ja/HB60wtY6E2sxAKoAnsdN0G1L6yktBSy+E0e0GXlmjNwzE4eTUMU4Y0lf9wWDOJ4tMiiueUEHZgSH+gAFKM1/U0cAtwg2fProEGmoSX2H9H9VXYYL2YNRVM6HbCikA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fKlKYeebcd7suqRpHMaupqRDUS7ZBfKGX+d6H3pzqI=;
 b=VkKzpOuPro6sTcYCGtiNpozI5chteLBX/3FW8gZsEuhECv5H6HwMtGbDpYKz4k3GDdOCoGGeXL/g8LF4uNcZDcGNkU5p+38PjxZI4rzpHhvqTWRiXPZeFomcc1X9RIYr8fw+yVbqzwH36eYIycw1x3tL1zUbqXBmWGNbB5LyKls=
Received: from DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17)
 by DM6PR10MB4137.namprd10.prod.outlook.com (2603:10b6:5:217::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Wed, 11 Aug
 2021 11:50:39 +0000
Received: from DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::496:2301:77d9:de82]) by DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::496:2301:77d9:de82%9]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 11:50:39 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Prabhakar Kushwaha <pkushwaha@marvell.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "mkalderon@marvell.com" <mkalderon@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "smalin@marvell.com" <smalin@marvell.com>,
        "aelior@marvell.com" <aelior@marvell.com>,
        "prabhakar.pkin@gmail.com" <prabhakar.pkin@gmail.com>,
        "malin1024@gmail.com" <malin1024@gmail.com>
Subject: Re: [PATCH for-next] qedr: Move variables reset to
 qedr_set_common_qp_params()
Thread-Topic: [PATCH for-next] qedr: Move variables reset to
 qedr_set_common_qp_params()
Thread-Index: AQHXjnAiC65XUocsvkeIJ4/97FMaAqtuL74AgAABlgA=
Date:   Wed, 11 Aug 2021 11:50:39 +0000
Message-ID: <27B07D29-E863-4561-BDE1-4D687004C782@oracle.com>
References: <20210811051650.14914-1-pkushwaha@marvell.com>
 <20210811114458.GA7008@nvidia.com>
In-Reply-To: <20210811114458.GA7008@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ed110ab-b14c-4111-a4dd-08d95cbe3dbc
x-ms-traffictypediagnostic: DM6PR10MB4137:
x-microsoft-antispam-prvs: <DM6PR10MB413728B28A435007DB21CFB7FDF89@DM6PR10MB4137.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UUjahmblEmVQ9hbEvdevsw+1EH4JYsh4nFbp1jcI+MdfGF8b4DJ1fDTBnenNhmQeqFcTcz2j5meNnql8HRzhmk4sgatHX3/795rs5u7a1lPshqLXToRr6IiUmObH9T1x4DxlbXztU4Tn/KVz8wKXRRl98awIAc8UYxXCqtaCUiwWTSUnKHdmSCkosdqLRYC6/1ZFUYdmLHLPj7ujkqIsb+PQ9Y3eBMuQdrTNWBRlp3OZ/lfVk/3RI56eZNk6orlE7DZpeS0tcRCztau0DScWrJ3N0rehfpiuW9SfQA+1Sqno0x7MyEuJIt7axpH6wAshAxcyd2oaOx3gZnY9nAygL/2BAuuNYgW1cjjpvc55wa9Sumb8+y6sG+ukF4IpwhYJ9LmZrpPYQc2yvppisIpRK2wXoqMT4q5K9cSuEvtDxTlSmvU2SyqvWqSz0bglicJ9RBFwC+zbhFlYjZWDI8SbMTPQ3CUfXdrk9Cny2waE1BmASFzdbkrbIP4ZIC0iErU3/s90MWQWy7bkG4SgBJU2sUfMujnF7ICcKnPAgRjOrzTi2VL+9MjbIZf6MPoABlTTzDsdnX1h3cx8JXDbceotSMgWIaewdYh/9mp77hfeebW2ldlNP5gN5P+G1xNKB0QZlkD6Kz61Ztszvf6nVMg3tlqsKZzakXdPXWEatMBEDx7IAjDhtFZiCPUj7YdBUMIeXmpMBR72/zzOzNl2q38q6NoIBK5J5ItfzJ514tW+6X6q+oWVSlQtV7g7iy+9Gwb3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4863.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(396003)(376002)(346002)(38100700002)(53546011)(6506007)(4326008)(478600001)(2906002)(5660300002)(86362001)(4744005)(33656002)(122000001)(6916009)(71200400001)(26005)(8936002)(316002)(36756003)(186003)(64756008)(66446008)(44832011)(66476007)(66556008)(91956017)(38070700005)(66946007)(6486002)(7416002)(6512007)(54906003)(2616005)(76116006)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmI5dEM3R2cra3pPWEFTbG90MjI5NldiT2FQclZTcEhGa0lralc5eW90SmEv?=
 =?utf-8?B?YkFHS2ZtSk9RYm1ZTnEyRE9JTmFmbGZRcmhEcS9QdXNrUjBGdG9leU1UdEpn?=
 =?utf-8?B?emxWTXBFbm1CdzlzRjMxTGlGL1RKSml1UTJ3Z2JCMEFvLzRaMGJYSUVqS0pQ?=
 =?utf-8?B?eDV5eUt6NitwazZjVVF3RnFaQ0tkaUJtTXB2eUtweWE5Yis4YWxwZ2UwSUlP?=
 =?utf-8?B?a2ErcWlTMUNZOHVqQTRDTmcrenJ5d3BXTnppU0JwV055Ui9rWEhOellFR2Ry?=
 =?utf-8?B?S0ZLK2kxc0xGV2VBOXBlM0VabVNhc1d2SUVGRm5pZ1FTeWE1QzJYWjdjUTVn?=
 =?utf-8?B?eEJvV3gybUpyWkpGaTRrZXJDMjVGTjIwYlg5bUVIRVpvVlNmNXVrQkhYN2Ez?=
 =?utf-8?B?VDcrcUI0WVpRM1RhYXN0YmtJM0t5OVhPN2pWY3RSc1lJMjdpWG1xTWpjWHV4?=
 =?utf-8?B?MkRRNmh5bHlnOFFLUi9VTnl0aGc2NzlxMDloUVQ2WWZiSTVRSFpVbW8vR2FH?=
 =?utf-8?B?Mi91c0pGY1dNS01hVmRtZ3VZd2ZYa0hmTTVjelIwdlhucjJScVBpWDhwc0JN?=
 =?utf-8?B?cWM0QUQ4WURuOGp5MHdOTjV4WmxOK3JpWFhUS3ZtS3cwS0ovSUF2TTR0U3NT?=
 =?utf-8?B?dllkVzE5RUJCTjQ4VmNWdkcyY2pubVNDMEFvRXd6UmNxekp2ZndBamhKRk53?=
 =?utf-8?B?RWcxVzJQUjdNb0cwVkdZb1JUT3FJQ3hkSUpocitDUXF3Y2V3dWt1Um9oS1dV?=
 =?utf-8?B?RDUrQ09DaVVjcEMvb3ljYXNnMlZrVHN5ZENHci9ycVo2cDdLTUFWRlI5blNr?=
 =?utf-8?B?NWZBZjUyT24zejlGd29vYkV6cFhHZU1SdTdwd0pzTk9FYWJwV25mcWt5a3dz?=
 =?utf-8?B?OXB2Z0ZZeENhMEtsb1FNZjE1akZXcFJSaXdDL2o5eGc4SENVWDFrUjgvNEY4?=
 =?utf-8?B?RVZiOWwwcEpITTVKdmpDL1NKd2lqcDNvZW9lbTkxRWpjRkEreUpCamhKWGw2?=
 =?utf-8?B?aGVTV3grLzlWQmFLSHJGQmlUYWZnazYwSkxyUEsyN2pCTzdyd0YwdVQzWXRr?=
 =?utf-8?B?dXRhQkhUZTRaK1daOGI0VnMxOUNMWWdOUTI2N2FLeDV2LzQ2Y3RUZGtmUkRu?=
 =?utf-8?B?SVFaNGk3UzgyVDhGOXlJbnRqbTBkL01oUjAyeVJvU3pyYkhvWWM5ZVkzUFYr?=
 =?utf-8?B?TEJCRDQ3Z2lwWUljVXFQMWZtd2lYc1hQbmJvcHp6MjJoSVNiSWQ3aWxaY0Ro?=
 =?utf-8?B?T2tRRnYyc2dONXZTdm5GSkZrWkRjM0s4djJYZmo5aUIrbVc2RTBWbjJ2MWNt?=
 =?utf-8?B?Y3FINWY5bDFWei9YNGJIWHlhMWs5RXFrNEl0UkZib2lQWXlObW5FR1cwbmM2?=
 =?utf-8?B?eVUvcjIzYVNHQUo4YVJmU3lNZjJ2YUxDWGNmNFYyaWl5QitCSlgvVUhxMDE5?=
 =?utf-8?B?VkU1L04wK05TeHBvakp4WFp4TkVLY051emNyMHZwSkNxazh5ZG5YdHF0M1Zm?=
 =?utf-8?B?aXZVd1hNN2dteGFhRitNU3JLdWhLMmlqTnp1YVNsaU5raXNVVDdiZXpqSjVK?=
 =?utf-8?B?K0lQdU11RHQzclVUK1E1QnFQWk1ELzZpTERxTXlQMzJJSDhnL2ZHcnhTb0Zu?=
 =?utf-8?B?SGxWU2I5YnhOUExqRGlhWGJGNUxENnBhUFJXM1hvTVlMcHhob3RXT1RDNnR3?=
 =?utf-8?B?N1hjTzcwb05tUTduWEhkUmE2ek5IQkVMeldTajlWNDVLZkVqeElLdHdSZlpy?=
 =?utf-8?Q?Y33e1WBUBpe5VX0BugmVW5CQvL6BsjsX4BsOoMP?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <591F15E9DC1D0C45AB6758EC36534CEC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4863.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed110ab-b14c-4111-a4dd-08d95cbe3dbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 11:50:39.8044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8THDE4s6rQ/80QUnnSghB04vF+q6rCmeBgvzM2XacQpR9qEsHHxcX+T5lF19BnE6Omcohe17MA3Xr5bR28kUdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4137
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10072 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108110078
X-Proofpoint-ORIG-GUID: jZIRyd6f6yYRMFjONIQw7XfdJ2IN0QK8
X-Proofpoint-GUID: jZIRyd6f6yYRMFjONIQw7XfdJ2IN0QK8
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTEgQXVnIDIwMjEsIGF0IDEzOjQ0LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgQXVnIDExLCAyMDIxIGF0IDA4OjE2OjUwQU0g
KzAzMDAsIFByYWJoYWthciBLdXNod2FoYSB3cm90ZToNCj4+IFFlZHIgY29kZSBpcyB0aWdodGx5
IGNvdXBsZWQgd2l0aCBleGlzdGluZyBib3RoIElOSVQgdHJhbnNpdGlvbnMuDQo+PiBIZXJlLCBk
dXJpbmcgZmlyc3QgSU5JVCB0cmFuc2l0aW9uIGFsbCB2YXJpYWJsZXMgYXJlIHJlc2V0IGFuZA0K
Pj4gdGhlIFJFU0VUIHN0YXRlIGlzIGNoZWNrZWQgaW4gcG9zdF9yZWN2KCkgYmVmb3JlIGFueSBw
b3N0aW5nLg0KPj4gDQo+PiBDb21taXQgZGM3MGY3YzNlZDM0ICgiUkRNQS9jbWE6IFJlbW92ZSB1
bm5lY2Vzc2FyeSBJTklULT5JTklUDQo+PiB0cmFuc2l0aW9uIikgZXhwb3NlZCB0aGlzIGJ1Zy4N
Cj4gDQo+IA0KPiBTaW5jZSB3ZSBhcmUgcmV2ZXJ0aW5nIHRoaXMgdGhlIHBhdGNoIHN0aWxsIG1h
a3NlIHNlbnNlPyBDZXJ0YWlubHkNCj4gaGF2aW5nIGEgZHJpdmVyIGRlcGVuZCBvbiB0d28gaW5p
dC0+aW5pdCB0cmFuc2l0aW9ucyBzZWVtcyB3cm9uZyB0byBtZQ0KDQpJZiB3aGF0IEkgd3JvdGUg
YWJvdXQgYWRoZXJpbmcgdG8gdGhlIElCVEEgc3BlYyBhbmQgdHJhbnNpdGlvbiB0aGUgUVAgdG8g
SU5JVCBkdXJpbmcgcmRtYV97Y29ubmVjdCxhY2NlcHR9IG1ha2VzIHNlbnNlLCBJIHRoaW5rIHdl
IG5lZWQgYSB0d28tcGhhc2VkIGFwcHJvYWNoLg0KDQoxLiBHZXQgdGhlIFVMUHMgdG8gYWRoZXJl
LiBUaGF0IHdvdWxkIG5vdCBkZW1hbmQgYW55IGNoYW5nZXMgaW4gY21hLg0KDQoyLiBPbmNlIDEg
aGFzIGJlZW4gcHJvdmVuIHdvcmtpbmcsIHdlIGNhbiBmaXggY21hIGFuZCBtYWtlIHRoZSB0cmFu
c2l0aW9uIHRvIElOSVQgaW4gcmRtYV97Y29ubmVjdCxhY2NlcHR9Lg0KDQpPSz8NCg0KDQpUaHhz
LCBIw6Vrb24NCg0K
