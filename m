Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B7C766B6F
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jul 2023 13:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbjG1LL0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jul 2023 07:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbjG1LLZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Jul 2023 07:11:25 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4E3FC
        for <linux-rdma@vger.kernel.org>; Fri, 28 Jul 2023 04:11:23 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SB8bvE000362;
        Fri, 28 Jul 2023 11:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=upD1efv5HYPPBxyTdWXyrfjH+EDaJjbTzGU81mvlJqo=;
 b=IchS72k0+ic4w3Pu9+1MgLqTeveSaxJdqVvrr9tnWmmhtCKMZpfrxFlSgXz9E7UOoLCG
 gU0zCpbcGj9hcsHfDjdBrggkYTmNM4RjyFIGbP3mKce7jk1/AzGDrvliV0UZsyjQJrPv
 tp4kSDRQvI/R4XzCdsBWyWfSNhFE92YMrXBoaaSXb59L2Lk7R+xDj2/vyJXX4GxbJbDc
 ket2byQH5Jh3EhpeRTt2KeCud4/nM3t7f3D3hOQBUCSCJzlwefoNzLaGk+YsAsHKrawk
 3VPG/CO1UBDShyEApYNNGLed/phDAXXtgsTzAqkJ5/4atfbElrBC+CRHtTNmTDuY4RCT Jg== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s4bessrdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 11:11:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHooNpBzzXz3omdMFGYZVOGJnKiKumVDKGOCdwp0Qa59H0lGBK+DXqBO8gBhzeStdWebdN8vNwezmroLkwWEcLXzHXKR5TRoWJI13L6YhkHuUyFt+uhQ8HoTKeGg/qvIfZvmXoDwtrjhk9a57LF1jabdnlwTMevRYq+dWcyDU48SHx+0q6NHjLpIC8DrgEthR3GGk0MW6xPvYKnwoOy0lNLf/u/FmK5WZJV2sRqb/Z7vdHt7lagRH6zC3P2uzw/3xjATqtiv7PWiZJ4ID1gCPHASOZ6EafaKsa5vPpGq631bpyKB/MfsXrlNXKxUhQRw8Zgl8lKLtjt9d7B+BSUhaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upD1efv5HYPPBxyTdWXyrfjH+EDaJjbTzGU81mvlJqo=;
 b=WKuJxL4xW2l0QkwI5RCC6PfNGC9ZZFnlfueytoOz/Q7hc4eUQDRWY4YWCSpv2QGvRGuhYzjeekFSrSJoPEy2pxexEOUtD2bbhVy3ZboUCZd6jZkr3vBUXSz/fd9owqkr5zfoijK7lVcLYBEH+ZjzaoOpbQE+AshVHDiJbnlGtW3CnA8BpHVnpspAtJfO6SVhswLBqp/RPsBIg4xJ5Uu6Ciu5on5orAadysuGqXLYg6o96SZ84sWpjhCzC6s3RbU5qY/b7sxRNrgXeD9m7v00HxyjZOhwyWsOxX6pD/3BINRNn5xdnQMHkKzzChTkcaq5v8e8LReiYQTC9r5cIp/TAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by MW3PR15MB4009.namprd15.prod.outlook.com (2603:10b6:303:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 11:10:15 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::1dd2:5249:6029:1011]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::1dd2:5249:6029:1011%4]) with mapi id 15.20.6609.024; Fri, 28 Jul 2023
 11:10:15 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH 0/5] Fix potential issues for siw
Thread-Index: AQHZwK4/o6ZrLeh//E+K+kLVHm/vsK/N3mWAgACCeICAABRiAIAAe+Ew
Date:   Fri, 28 Jul 2023 11:10:15 +0000
Message-ID: <SN7PR15MB57556B905C69ADB688D2A3D79906A@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20230727140349.25369-1-guoqing.jiang@linux.dev>
 <SN7PR15MB575506FAF5423F726708AF8F9901A@SN7PR15MB5755.namprd15.prod.outlook.com>
 <ZMKpcQsJ3FBvxYHo@ziepe.ca> <35286616-a53d-7aa5-b3b0-09ae44edf510@linux.dev>
 <684f6b40-8d02-a273-2192-9c2499bd555a@linux.dev>
In-Reply-To: <684f6b40-8d02-a273-2192-9c2499bd555a@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|MW3PR15MB4009:EE_
x-ms-office365-filtering-correlation-id: 95c8c6bc-2dc8-4ba0-3fb1-08db8f5b3839
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tolf4dCVSR4Lh9UV947Q7E51smI2V65nwLl8pzMPw21X9yjo5id4X4astV52Fmt999XfKGSU+ADC7AsAu15y3C2Qi4HNx7okH5gwYRDq7uotSivSkHi7ZMBsrDNhJAhT1UWVNV4LaQe5sbj6F6wEixHibLeZmrO4shURIu79ScnTgCRwkJa7W/yMImYnQVZ2UjiOn9fj2LmR6lqCINq4I1SMc2OdlwLF1GV3GAWfQQsN/P5xxGw2Bvhq+aHKhLhFns5MPqsSFJqlJNI0jKH7g3qWm6GERA3NGtlywHIGNgbNn9SLlC5uWiBg7MQpGxCdbtVEFiWujqM3QPImlHHloXYIKALPNHPO4hY6XS+4BTO4V4WOKtMSAW7JnOWVnhXA+mNBnqvlimr2esvmO4mR/qB/ehADSga5PekSnPy4qtc60GCLR6GnBPzR/74crEtyflGXCWAUR+wN+8NkqfWer59C1ud7DyvyyKrliQbmUBNmyShpLmhdjBsln5/CVAKLnd65Ltin39H4GKW6It984GL3pqGwRp8IzGQJvkogRZrKVbMVRfvmVNOPzBzz3X+2qM8mdqQ21fxiCQDzrCI98YxFyu0mKIfCpXheO/Vz0rFJN8VNn0avKOg9ZlRpawHL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199021)(54906003)(7696005)(110136005)(9686003)(478600001)(33656002)(83380400001)(86362001)(55016003)(38070700005)(2906002)(71200400001)(66556008)(66476007)(66446008)(6506007)(186003)(64756008)(53546011)(122000001)(76116006)(38100700002)(8936002)(52536014)(316002)(8676002)(41300700001)(4326008)(5660300002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXlieE96NTZEeDI4TlRwVjMzaEFqL2xpcytGdkNFUFZzRVlxTXFucEM5ZExH?=
 =?utf-8?B?Z1ViVng0UUZpeTFzK2YrTGZEcnFJOFczbSsyZVNmc0d4YmZrQzV3MGgvcWtV?=
 =?utf-8?B?aU5rbEF2dllVRGxKYjU3eXJFL2Q3M0Rzb29ySjlpQTVTU3haS094cHNMMkJE?=
 =?utf-8?B?V0hxcFFEMjZzam1aQXp3MUcvd2pzTjdzY2tzRldacFFzTjA0OGR5TnYvdHB6?=
 =?utf-8?B?NlFsajNpQUhCL0hCVWIyOUdrd0d6R0dCWDY5SFpLOUVydXRtbmp6RDNXTGg5?=
 =?utf-8?B?T0lsSXZWVGtZTXRZbGRUYWNZUXFDYU1uRElYdHNzUDJCMlJsQ2EzNTliVTFo?=
 =?utf-8?B?M0NPRnZkSXh3N0dNc2tlMzRJbS9vSU5WNGpZdElrSCtIZEJsOWV2K3ovWWFN?=
 =?utf-8?B?QVY4ZCtLa0pDcDlabDVsbHNWWXB4WGNDMGpHdzdST3RmcWxNa1hpd0tERmV5?=
 =?utf-8?B?TmxMZ1d5dEhPY1ZGVnBEaUw5dXRUTmpvMkcxZWFXajI4eHBvVVFwcjlpTm13?=
 =?utf-8?B?QWs4Q1o2TUQ4eFg3TzRDSWMzQ3dESDNYRzZsOU5zQUh6aHVUUzR6Vzk2dSt1?=
 =?utf-8?B?eThaN3IrQ3k4bG9OdVlBMi9UemxXUHpZZ0hzY3RKQ2FMS2V3Wk1hdHVWTWMx?=
 =?utf-8?B?STIzeFkxcWJISC96ZlQxN1R4K2VGU2JzbXdqdlg0MUFkNmYzS1RHenVpdDEx?=
 =?utf-8?B?RjREMUZQSFdjMzA5UzFqZXYwR1hQeTVsWCs1QzdzaGxlS0VCMHpka2w2ejRo?=
 =?utf-8?B?a3NGdERzSmE1cGdpSGUzMUNZOGlCV2NyMVFack1lOHozT25DTDdHT2JTeVk5?=
 =?utf-8?B?NW5VSitybzBoSGdjVW92ZmtlMWM4ZmwvMVBDS1dOdXlKc212YlRReUJOdGlE?=
 =?utf-8?B?QTJkTGp4b01zOERPbk50UFdTVktZNU9CZFI3aHB2alRGUUg1cWxodFVqZklJ?=
 =?utf-8?B?ZUI5NUdqanNQT3pIWFpiZzVHY0VjRVVxd0JJWUtUanVBeVZMQ29UdHZXZE54?=
 =?utf-8?B?R0JMWTZzNHJQNjMwYlM5MGpBKysxUkU3VmlqbmIxeXlvd0Z1Wk1yMXlwNWRL?=
 =?utf-8?B?SnpGaWdvNjRXT1NVc2QwQnkwaHRVWk8vYzBhN01aNS9URHlHQlNJTmJrMG12?=
 =?utf-8?B?SVljRGxsWGoydGJmUE5VNXhXM1VhdnBTdnRpT3Qxdy9ibUR2anVaQlNSTWlF?=
 =?utf-8?B?NHdXU2c4WFVQU3JBWFY5Z1lwN3IybHFVTWJaN3NpcU5pMkt4WStzUFplZDAv?=
 =?utf-8?B?SDQ1Yzk1dEJBVWNGSE5pQVlyVVhjYi9mVGI5M0kzclJPRjJpV1h5QlRaYkh4?=
 =?utf-8?B?cU00MDBpTEEycDA0Q250eC9MdTFRSkJ4SFlkN0VrQTYzL1lIR1JMRWt5VjdF?=
 =?utf-8?B?VjRQV3loRDY3Vlg0SjJOeERDSTZwaUdtUEY2aVZIRnNpZGpnUWEwOUhuNU9B?=
 =?utf-8?B?Wi94eER2d01kOG5nZ2E5TmF6cVRzTHNBeVZ6cVhqaXF2cjE2T0RwVEcvZ1U3?=
 =?utf-8?B?aC9Ib29nYlgxeDkzMnhBQ05OL1F5ZThQYUZVU1g0a2lpMURpYWtKd2kvMkpp?=
 =?utf-8?B?eSthbnpWbkZjcE5DOERFOEg1dTlnWkxUSkMrS3hUVWlUcncwVWxDY3lONU51?=
 =?utf-8?B?UlEzcktyc1U4dGp4YStGTFFLRGIzcFlnMUk5Zk1vUVorSEZudlpKb1ltQ2VJ?=
 =?utf-8?B?ZFEyMEVWMFhoMU8zWVlaOGh2VWJnMU1PZ2FRS3BjUVNFZkpRR1ZYQVltQy9v?=
 =?utf-8?B?SWxLL294bjRRSHp0dlpWWXJQb0ppVmFGRnVqQ3UxTjFjZmtpbmxqcm9IZmcw?=
 =?utf-8?B?L1E3NzNHSmhlVS92RFI1OFdUNzF4TzV1TWFYaXZJbk9aQng5RFJ6SmZmUThw?=
 =?utf-8?B?K3RKdWpVa2dYN05hVndnUlRhcHBqKzdLbHk3M1BoSzhQTHBKWEN0M2JLa2k2?=
 =?utf-8?B?U1g5c3R4c0xvblEwOHcvd0trSzZkVnMwQmh6dmtEdWljUFl4a3JPSGJvWi9j?=
 =?utf-8?B?VlUwMVRrRFFVbG02WWZSdnVJRnpoZHJXVVFMRUxhVERCWWlMYSs1T3h5OWt0?=
 =?utf-8?B?MHd2Ulg1ZlAyZ0pOZnh3VDljRHRnYXJsTERhcXJwRW1DTkRmM0RqZ0VBdkdH?=
 =?utf-8?B?WlVLZEdpOGV3MjY0dndKV2tva0Y2QXZzcUlZL2xoRTVTeVltWEpPTXl0cGFC?=
 =?utf-8?Q?Di60FBxAx1c63OOgv7fDgTI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c8c6bc-2dc8-4ba0-3fb1-08db8f5b3839
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 11:10:15.0809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OxvcS3cnrAZR/FPS00x/Wka/Sw5z5Q6NcsCF6DsIaecRqorXskOps81ULZsRqiR5C7B0OQbOJxSgJFrc7gTn/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4009
X-Proofpoint-ORIG-GUID: hhwooXBl9-IbSd3l4OjDVTTI4dGX4hYP
X-Proofpoint-GUID: hhwooXBl9-IbSd3l4OjDVTTI4dGX4hYP
Subject: RE: [PATCH 0/5] Fix potential issues for siw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 mlxlogscore=863 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280102
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IEZyaWRheSwgMjggSnVseSAyMDIzIDA0
OjI5DQo+IFRvOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT47IEJlcm5hcmQgTWV0emxl
ciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiBDYzogbGVvbkBrZXJuZWwub3JnOyBsaW51eC1yZG1h
QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggMC81XSBG
aXggcG90ZW50aWFsIGlzc3VlcyBmb3Igc2l3DQo+IA0KPiANCj4gDQo+IE9uIDcvMjgvMjMgMDk6
MTYsIEd1b3FpbmcgSmlhbmcgd3JvdGU6DQo+ID4NCj4gPg0KPiA+IE9uIDcvMjgvMjMgMDE6Mjks
IEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gPj4gT24gVGh1LCBKdWwgMjcsIDIwMjMgYXQgMDU6
MTc6NDBQTSArMDAwMCwgQmVybmFyZCBNZXR6bGVyIHdyb3RlOg0KPiA+Pj4NCj4gPj4+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+IEZyb206IEd1b3FpbmcgSmlhbmcgPGd1b3Fp
bmcuamlhbmdAbGludXguZGV2Pg0KPiA+Pj4+IFNlbnQ6IFRodXJzZGF5LCAyNyBKdWx5IDIwMjMg
MTY6MDQNCj4gPj4+PiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+OyBq
Z2dAemllcGUuY2E7DQo+ID4+Pj4gbGVvbkBrZXJuZWwub3JnDQo+ID4+Pj4gQ2M6IGxpbnV4LXJk
bWFAdmdlci5rZXJuZWwub3JnDQo+ID4+Pj4gU3ViamVjdDogW0VYVEVSTkFMXSBbUEFUQ0ggMC81
XSBGaXggcG90ZW50aWFsIGlzc3VlcyBmb3Igc2l3DQo+ID4+Pj4NCj4gPj4+PiBIaSwNCj4gPj4+
Pg0KPiA+Pj4+IFNldmVyYWwgaXNzdWVzIGFwcGVhcmVkIGlmIHdlIHJtbW9kIHNpdyBtb2R1bGUg
YWZ0ZXIgZmFpbGVkIHRvIGluc2VydA0KPiA+Pj4+IHRoZSBtb2R1bGUgKHdpdGggbWFudWFsIGNo
YW5nZSBsaWtlIGJlbG93KS4NCj4gPj4+Pg0KPiA+Pj4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9zaXcvc2l3X21haW4uYw0KPiA+Pj4+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9z
aXcvc2l3X21haW4uYw0KPiA+Pj4+IEBAIC01NzcsNiArNTc3LDcgQEAgc3RhdGljIF9faW5pdCBp
bnQgc2l3X2luaXRfbW9kdWxlKHZvaWQpDQo+ID4+Pj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAocnYp
DQo+ID4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXRfZXJyb3I7
DQo+ID4+Pj4NCj4gPj4+PiArwqDCoMKgwqDCoMKgIGdvdG8gb3V0X2Vycm9yOw0KPiA+Pj4+IMKg
wqDCoMKgwqDCoMKgwqAgcmRtYV9saW5rX3JlZ2lzdGVyKCZzaXdfbGlua19vcHMpOw0KPiA+Pj4+
DQo+ID4+Pj4gQmFzaWNhbGx5LCB0aGVzZSBpc3N1ZXMgYXJlIGRvdWJsZSBmcmVlLCB1c2UgYmVm
b3JlIGluaXRhbGl6YXRpb24gb3INCj4gPj4+PiBudWxsIHBvaW50ZXIgZGVyZWZlcmVuY2UuIEZv
ciBtb3JlIGRldGFpbHMsIHBscyByZXZpZXcgdGhlIGluZGl2aWR1YWwNCj4gPj4+PiBwYXRjaC4N
Cj4gPj4+Pg0KPiA+Pj4+IFRoYW5rcywNCj4gPj4+PiBHdW9xaW5nDQo+ID4+PiBIaSBHdW9xaW5n
LA0KPiA+Pj4NCj4gPj4+IHZlcnkgZ29vZCBjYXRjaCwgdGhhbmsgeW91LiBJIHdhcyB1bmRlciB0
aGUgd3JvbmcgYXNzdW1wdGlvbiBhDQo+ID4+PiBtb2R1bGUgaXMgbm90IGxvYWRlZCBpZiB0aGUg
aW5pdF9tb2R1bGUoKSByZXR1cm5zIGEgdmFsdWUuDQo+ID4+IEkgdGhpbmsgdGhhdCBpcyBhY3R1
YWxseSB0cnVlLCBpc24ndCBpdD8gSSdtIGNvbmZ1c2VkPw0KPiA+DQo+ID4gWWVzLCB5b3UgYXJl
IHJpZ2h0LiBTaW5jZSBydiBpcyBzdGlsbCAwLCBzbyB0aGUgbW9kdWxlIGFwcGVhcnMgaW4gdGhl
DQo+ID4ga2VybmVsLiBOb3Qgc3VyZSBpZiBzb21lIHRvb2wgY291bGQgaW5qZWN0IGVyciBsaWtl
IHRoaXMuIEZlZWwgZnJlZSB0bw0KPiA+IGlnbm9yZSB0aGlzLg0KPiANCj4gVGhlIGJlbG93IHRy
YWNlIGhhcHBlbmVkIGlmIEkgcnVuIGEgc3RyZXNzIHRlc3Qgd2l0aCBsb2FkIHNpdyBtb2R1bGUg
YW5kDQo+IHVubG9hZCBzaXcgaW4gYSBsb29wLCB3aGljaCBzaG91bGQgYmUgZml4ZWQgYnkgcGF0
Y2ggNSzCoCBzbyBJIHRoaW5rIHdlDQo+IG5lZWQgdG8gYXBwbHkgaXQsIHdoYXQgZG8geW91IHRo
aW5rPw0KDQpJIHNlZS4gbWFrZXMgc2Vuc2UgLS0geW91IGFyZSByZW1vdmluZyB0aGUgbW9kdWxl
IHdoaWxlIHNvbWUgdHgNCnRocmVhZHMgZGlkIG5vdCBnZXQgYSBjaGFuY2UgdG8gaW5pdCB0aGVp
ciBzdGF0ZS4NCldoeSBkb24ndCB3ZSBiZXR0ZXIgY2xlYW5seSBpbml0aWFsaXplIHRoZSB0YXNr
cyBzdGF0ZSBiZWZvcmUNCnNwYXduaW5nIGl0PyBZb3VyIGV4dHJhIHRhc2sgcGFyYW1ldGVyICdy
dW5uaW5nJyBzbWVsbHMgbGlrZQ0KaXQgY291bGQgbGVhZCB0byBhIHNpbWlsYXIgaXNzdWUgLSBh
dCBtb2R1bGUgcmVtb3ZhbCwgdGhlDQp0YXNrIG1heSBoYXZlIG5vdCBnZXQgYSBjaGFuY2UgdG8g
c2V0ICdydW5uaW5nJyB0cnVlLCBzbyBpdCBpcyBub3QNCnN0b3BwZWQgYW5kIGZpbmFsbHkgbGVm
dCBhbG9uZS4NCg0KV29ya2luZyBvbiBhbiBhY2NvcmRpbmcgcGF0Y2guLi4NCg0KVGhhbmtzLA0K
QmVybmFyZC4NCg0KDQo+IA0KPiBbwqAgNDE0LjUzNzk2MV0gQlVHOiBzcGlubG9jayBiYWQgbWFn
aWMgb24gQ1BVIzAsIG1vZHByb2JlLzM3MjINCj4gW8KgIDQxNC41Mzc5NjVdwqAgbG9jazogMHhm
ZmZmOWQ4NDdiYzM4MGU4LCAubWFnaWM6IDAwMDAwMDAwLCAub3duZXI6DQo+IDxub25lPi8tMSwg
Lm93bmVyX2NwdTogMA0KPiBbwqAgNDE0LjUzNzk2OV0gQ1BVOiAwIFBJRDogMzcyMiBDb21tOiBt
b2Rwcm9iZSBUYWludGVkOiBHIE9FDQo+IDYuNS4wLXJjMysgIzE2DQo+IFvCoCA0MTQuNTM3OTcx
XSBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChRMzUgKyBJQ0g5LCAyMDA5KSwgQklP
Uw0KPiByZWwtMS4xNi4wLTAtZ2QyMzk1NTJjLXJlYnVpbHQub3BlbnN1c2Uub3JnIDA0LzAxLzIw
MTQNCj4gW8KgIDQxNC41Mzc5NzNdIENhbGwgVHJhY2U6DQo+IFvCoCA0MTQuNTM3OTczXcKgIDxU
QVNLPg0KPiBbwqAgNDE0LjUzNzk3NV3CoCBkdW1wX3N0YWNrX2x2bCsweDc3LzB4ZDANCj4gW8Kg
IDQxNC41Mzc5NzldwqAgZHVtcF9zdGFjaysweDEwLzB4MjANCj4gW8KgIDQxNC41Mzc5ODFdwqAg
c3Bpbl9idWcrMHhhNS8weGQwDQo+IFvCoCA0MTQuNTM3OTg0XcKgIGRvX3Jhd19zcGluX2xvY2sr
MHg5MC8weGQwDQo+IFvCoCA0MTQuNTM3OTg1XcKgIF9yYXdfc3Bpbl9sb2NrX2lycXNhdmUrMHg1
Ni8weDgwDQo+IFvCoCA0MTQuNTM3OTg4XcKgID8gX193YWtlX3VwX2NvbW1vbl9sb2NrKzB4NjMv
MHhkMA0KPiBbwqAgNDE0LjUzNzk5MF3CoCBfX3dha2VfdXBfY29tbW9uX2xvY2srMHg2My8weGQw
DQo+IFvCoCA0MTQuNTM3OTkyXcKgIF9fd2FrZV91cCsweDEzLzB4MzANCj4gW8KgIDQxNC41Mzc5
OTRdwqAgc2l3X3N0b3BfdHhfdGhyZWFkKzB4NDkvMHg3MCBbc2l3XQ0KPiBbwqAgNDE0LjUzODAw
MF3CoCBzaXdfZXhpdF9tb2R1bGUrMHgzMC8weDYyMCBbc2l3XQ0KPiBbwqAgNDE0LjUzODAwNl3C
oCBfX2RvX3N5c19kZWxldGVfbW9kdWxlLmNvbnN0cHJvcC4wKzB4MThmLzB4MzAwDQo+IFvCoCA0
MTQuNTM4MDA4XcKgID8gc3lzY2FsbF9lbnRlcl9mcm9tX3VzZXJfbW9kZSsweDIxLzB4NzANCj4g
W8KgIDQxNC41MzgwMTBdwqAgPyBfX3RoaXNfY3B1X3ByZWVtcHRfY2hlY2srMHgxMy8weDIwDQo+
IFvCoCA0MTQuNTM4MDEyXcKgID8gbG9ja2RlcF9oYXJkaXJxc19vbisweDg2LzB4MTIwDQo+IFvC
oCA0MTQuNTM4MDE0XcKgIF9feDY0X3N5c19kZWxldGVfbW9kdWxlKzB4MTIvMHgyMA0KPiBbwqAg
NDE0LjUzODAxNl3CoCBkb19zeXNjYWxsXzY0KzB4NWMvMHg5MA0KPiBbwqAgNDE0LjUzODAxOV3C
oCA/IGRvX3N5c2NhbGxfNjQrMHg2OS8weDkwDQo+IFvCoCA0MTQuNTM4MDIwXcKgID8gX190aGlz
X2NwdV9wcmVlbXB0X2NoZWNrKzB4MTMvMHgyMA0KPiBbwqAgNDE0LjUzODAyMl3CoCA/IGxvY2tk
ZXBfaGFyZGlycXNfb24rMHg4Ni8weDEyMA0KPiBbwqAgNDE0LjUzODAyNF3CoCA/IHN5c2NhbGxf
ZXhpdF90b191c2VyX21vZGUrMHgzNy8weDUwDQo+IFvCoCA0MTQuNTM4MDI1XcKgID8gZG9fc3lz
Y2FsbF82NCsweDY5LzB4OTANCj4gW8KgIDQxNC41MzgwMjZdwqAgPyBzeXNjYWxsX2V4aXRfdG9f
dXNlcl9tb2RlKzB4MzcvMHg1MA0KPiBbwqAgNDE0LjUzODAyN13CoCA/IGRvX3N5c2NhbGxfNjQr
MHg2OS8weDkwDQo+IFvCoCA0MTQuNTM4MDI5XcKgID8gc3lzY2FsbF9leGl0X3RvX3VzZXJfbW9k
ZSsweDM3LzB4NTANCj4gW8KgIDQxNC41MzgwMzBdwqAgPyBkb19zeXNjYWxsXzY0KzB4NjkvMHg5
MA0KPiBbwqAgNDE0LjUzODAzMl3CoCA/IGlycWVudHJ5X2V4aXRfdG9fdXNlcl9tb2RlKzB4MjUv
MHgzMA0KPiBbwqAgNDE0LjUzODAzM13CoCA/IGlycWVudHJ5X2V4aXQrMHg3Ny8weGIwDQo+IFvC
oCA0MTQuNTM4MDM0XcKgID8gZXhjX3BhZ2VfZmF1bHQrMHhhZS8weDI0MA0KPiBbwqAgNDE0LjUz
ODAzNl3CoCBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg2ZS8weGQ4DQo+IFvCoCA0
MTQuNTM4MDM4XSBSSVA6IDAwMzM6MHg3ZjE3N2ViMjZjOWINCj4gDQo+IFRoYW5rcywNCj4gR3Vv
cWluZw0K
