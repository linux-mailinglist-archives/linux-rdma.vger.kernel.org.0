Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D66615DAE
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 09:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiKBIbS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Nov 2022 04:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKBIbR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Nov 2022 04:31:17 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993C8240AF
        for <linux-rdma@vger.kernel.org>; Wed,  2 Nov 2022 01:31:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cq0U34IVDTJUs0fT9nBKSl7hgG2WzHvlQODJdtwAwGMweEOsQSfyd/V74t1H9eCsesUBDkjq9/lZnHC5wLm5DI4JGkj0+T1UxKx/CHlgMsgJZN0UoiVKjykdFbg75L9uorzHMv9dNgSUuKZw1cTUbU418BuU+11FnVxkl9ckqzyw+FTjTj0pvqzTWNXmE1SGLAuCpR8tPW34LY4mgrJ/TdIj15m0NvBpedFpHRzhnYxKHC7sCa9gGIbbUjBEr5PtdGoRutWVJB/2T6D8wFj8jj0Xzzz7g206th2h1Vi96qN967bq5VU2lk+tEjiGcAxc/heXcPCZHXD+DaMvLbnJgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaCgccYWEw/ukhiTFxeVv+shY2RNRQ2rDGjWF2ktgTQ=;
 b=OHtaEl1yD+c5JdqTf3QmufVy3gMZJVCFbGxUeaq7DJzVFbh1ulmmzXOYDcbvibs4eiUX1WPPk/FOjwvr+vI4zRHuNRL8DibrFP6pxkSqfkdJmEefMo5mrFl4ZB+5qbTdIXbXPLJ7zVRRVd718MD06vfu0uhKzD42SwyJf2qJ3lzxjYvkglwYE938pX8prP39Zsds2/D6jj53bzPgaw78xJGC9WchyKSb7fW33dbR28+JY5qe/6OXmzH19luMerj7jHR80f1W4Sc8e6xDJdZ21VhgEsbf+7WekUcBjRmKMDD9k/kIFwMqLeTMhG8iDz+IovwElVzG3Bjeb/S2mkKEiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaCgccYWEw/ukhiTFxeVv+shY2RNRQ2rDGjWF2ktgTQ=;
 b=R1tMzocMf4Bic234q5egXSAeRflYVfRqtbGOXzltqIP4Q+8VjiU4bIchQI2eCshRbXXCdW9qx39j242e6Bu9DAvVZBLlfjrIAwrc4e9p6A8YZakjdYqpAm6V7uGEnaeqm8E7bP4bxx4TSBDuuxmICzBTkWx2SpMK6qdo5vdBxwWYo0EhxCXrxzq0HG2dUl71paxAQF53BERrHoCwnX+bLrSqNlXg+jLcOp5OEvpipY0d9uC7Vj9h9on653HjrsRA46ZYhBz3U5VspOoafDynEsirjpml4wraG1Ebtu/bjbP11O9EBTOBDmAm4An13SwNTDk9OfbzMAbxWIw/+6Jabw==
Received: from BL1PR12MB5143.namprd12.prod.outlook.com (2603:10b6:208:31b::13)
 by DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.21; Wed, 2 Nov 2022 08:30:13 +0000
Received: from BL1PR12MB5143.namprd12.prod.outlook.com
 ([fe80::5a56:1149:7a09:6eb5]) by BL1PR12MB5143.namprd12.prod.outlook.com
 ([fe80::5a56:1149:7a09:6eb5%6]) with mapi id 15.20.5769.019; Wed, 2 Nov 2022
 08:30:12 +0000
From:   Aleksandr Minchiu <alexmi@nvidia.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "ewg@lists.openfabrics.org" <ewg@lists.openfabrics.org>
Subject: [ANNOUNCE] ibsim 0.12 release
Thread-Topic: [ANNOUNCE] ibsim 0.12 release
Thread-Index: AdjulTfOjsQH0dhjRs21p2g2ajZCJQ==
Date:   Wed, 2 Nov 2022 08:30:12 +0000
Message-ID: <BL1PR12MB5143FA60144CF62F3D7796EDBC399@BL1PR12MB5143.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5143:EE_|DM8PR12MB5413:EE_
x-ms-office365-filtering-correlation-id: 8facf594-4fe2-410c-5130-08dabcac7623
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LIytrAwC4ag/zGMBitH8C+1vbg3ZpZF14Ul3kzJ2GprAEaku0AWL8XObW+7iPndKCAExwjG1g1mP/yhoh9t1Ah9Abg5GhY2PJ0ErHzs7AOJ29knhIdelFI4N7yGHqnPbltkO3ZGE3H0Y/n5rIpvttKdxR//hh9ViS9X9SR1XHu7NLMeZDALdYiOE2sTrkme7y6Ifn9Zfh4zEN9X77DVVYnTXeWl8jakK1PfsrtoBfCzZ3xqph7gFdy+zDJ4CuFlQQ/vnkLaePzQl6vm064uHuQYxsNBoUGfC90C6BJiDTyzDXAmKN0h8xkOFqomoJ00VxrHQDo/BKTgdw68y/NudOKbZF/+Tx3UoQOfWcNuYpoKLgJ9+qKKMAogJZN6Oyh3HfWIeDEajsl0qi8eyFHrNNRc5/X21y1GBrnfic+Py9nR+Cg/+LbysAQRISYpSAIxcwANjcNywAzoXhkebaO2iqO7KirI/SUmOYOkwrjZR/6/SpqIt47uKoKNx9CsQcaeIr5ZXJ5WW0zjbkLdreaR+QWmp4rutlm5RHts/MVMHrsAiefeVVFnL527/oUJTMBGkIx6vpFDweVoz4VxMA6rRQA/CjH/tdnu2QfNBizzvyCRH6BlJDzxH6ZVxPhIF6t2OiP6pPT3toaeVw4xVGKKLOl7XbjEMGzcWhGXy8fOdfYbF6moml4Lz9w+fb43rdGQ7ewUIjV6wd2Xh8BW8dmXXQ8jNXpKRvAGLyE1AjG8txUNFP66D4VwXIUPyWOWnvPISFiC56AtbT4UBN6lLcu4dHZCoO5vLl1djp6hAmHAjTmKh6E2EPbeSj4gdfSWS96iLJo2vSx8RtJhkEYvuvbsxEp9XhluDroZ2gwYQ0VSnj1s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5143.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199015)(9686003)(83380400001)(38070700005)(186003)(86362001)(33656002)(122000001)(38100700002)(4744005)(5660300002)(2906002)(66556008)(52536014)(8676002)(66446008)(66946007)(8936002)(66476007)(64756008)(6506007)(76116006)(26005)(316002)(110136005)(478600001)(966005)(7696005)(41300700001)(71200400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnNsendaUzhMT1Ftc2RVdDRWMlFKeDRtK3V1U1BxYWptSDRHckd2UVZNaEZz?=
 =?utf-8?B?QSsxay9mVmlhRUZJR1daN3B1Uisxb1V6R2VmeTZYS0g0TTZjZit3QnpoUFhE?=
 =?utf-8?B?aGFQUUgwWnNUTnMxVDNuOUU1bWpEVDV1ZGVPenU4SVlkNlBMbWs1cEVoZjFM?=
 =?utf-8?B?N1E1bWJURDZ6alU4aTBaWFZuM050VURmSThmZm5SUThMdEFNbm45d2hadW16?=
 =?utf-8?B?K040L2VSbGk4Vi9DYWxsU0JjYlpsSlFsN09yZEN4bUdneDFtNHBhVmREUE1V?=
 =?utf-8?B?QzN4OGZjc3NkWVJOdHI3ZzFkT0pTNUhXTDY0ckdVWElFUHp3VksxM3A4YzFQ?=
 =?utf-8?B?THZDZVpYV0h6Y0pnajl5aWZpYWVOeXhUdUp4Nzg5d3pqWmRtTEYyWnFDRU9L?=
 =?utf-8?B?RzNCVWhoYzB6MW1yR3VUd2UvNzdRY29WUUV0UFdOQ1loS05oSGRLdk9MU3Nz?=
 =?utf-8?B?R0kwVjJjSnVOaWhsQjFKZnFxMDJKSGdPUUg4WkRjeFNrUXZZazN6bkd6ZUFK?=
 =?utf-8?B?T0xsSFJHNmhCQ0pNeXhtcXovUXg1ZngwczFpNElhdEhrbldUMUg2QlJiV3pI?=
 =?utf-8?B?elBxODJwQXRFcnpiMHlXSnFzM25yS3RTUk5FOCtkNFpwbGFETGJNZlFSVUd0?=
 =?utf-8?B?cWNZTi9vNno4TjdGbVI4bGlkS05Vbi9PUTY5YTRMUmJBUVFYNm10SHV2aVdr?=
 =?utf-8?B?VGU2WUVpekRnaUtkb2dJMmQwV1pNbjkrdE9WaHAyNnhHT3M0NGp5Z2Rwc2FM?=
 =?utf-8?B?SUJYUXNEYjVMWDljbmw0YWkxNUVtR0xvVmFXajJwR3NhZ1drRW1SUTVJUHBS?=
 =?utf-8?B?R0FxbmNuem10N0tKM2RXNEFXeHU4anhISEt6cTQxTzBoVDJHNVRFV3B4cTdy?=
 =?utf-8?B?SndUL2tEcFkxSU04a1lQam55c3VXT0ZTYllENTUvblk5U29wYThXd3dNb3dW?=
 =?utf-8?B?TmJ0ZVpkKzlvaXV6MHhOR1owa05kQlF3bXFITFR1blFIeUdKdzRMaGZnaXd3?=
 =?utf-8?B?UFc5WU1Wb2N2NG9KNFlKTU9kRWt6LzVFbFk4dlJ6cHVJSGQwUHVLdlpZV1dR?=
 =?utf-8?B?cFNtQnphQ0IwZFU5SE1ldC9PbzlEWlV3ak9WSFdPcjY0NUE0QkpwYnRucUJj?=
 =?utf-8?B?NjE1UW9acmRVUHB3dVczcnhhVndyNWxSOHdjWFc5V1BlcGJLeFBiL1p0TmJs?=
 =?utf-8?B?cWlnazdPbmpnZnh5V2F6WWxVUWkzbTBCQzg4VlZ1eDlPM3Q4d3V1N1c3WDN2?=
 =?utf-8?B?eVVpTHhBQXhxUzMwTk1VK1ZBblRNRE1tTEtTRVd5YmsyQzBvTGxQK1hHbzlB?=
 =?utf-8?B?TDRXbEl3Ryt5OGpzcmp0R0tqQmwxL3dRd0N4VkliN2dDZCtZR0RUZkxjNFBZ?=
 =?utf-8?B?blV2SEs5Y3JyKy84R0w4QktyREFpam1UTWdPczJYaTN3bm1BekY4L1NqUFVJ?=
 =?utf-8?B?SUIzWXpnS1dyRlU1VjNzcjNqT01sS2J2V2FoenBMRS9BSTlFeVJ5dVhLWm84?=
 =?utf-8?B?Qks5UTNmVXBSKzF6Y2M3QUNCRUduTThoc0JVL2pGRkFYZjRrd2dYSTBxRjRw?=
 =?utf-8?B?TkxMbFNtclFYenU0Zk1NQzc2MU1yTUhjUEI0amR6TWhUK1RZQkl3WDFEMGln?=
 =?utf-8?B?SktBeTNid2FkL0N4clZ5VkxZRjRodURBMWM4MnV3ZmpHbVp5U0h0bWxTYlFz?=
 =?utf-8?B?b2NGbHlLMFVPTXlqMUltWmFyZFFJbEFtTDZacC9YV3JDYkNVUENydDdKMnVX?=
 =?utf-8?B?ZW4rZkwvVFNkQlFBREdSaUdRUnNQZEpNMzlwNC94YzNuKzRpTTZyOEtHTkhh?=
 =?utf-8?B?K3VLK241bkNPd0Z2aHNBNzN2MUhHUGxPeVpGM3BZOXlrcUIwcG1CTUZRV3dC?=
 =?utf-8?B?Slhldnd2cUNhazRzdGNiWjdRaVFxTG5Za0RPQ2RxejBlUHJTR1BBY2RHeFZR?=
 =?utf-8?B?cURaZkhjeVQzUldiYXpxOHJmZU01NTJDRTZodWthOFBrVTV0VjJBSklGcVJm?=
 =?utf-8?B?bE5pSjQrS0ZrV2ZKWDB0by9QQUFBRFV0ZlhkL29sQ3VaQ2o3cENrU1BuZVNp?=
 =?utf-8?B?TXNvRUcxUG5RQjJUTEVPckh4ak1XWTI5ZWFzZEdna2F4czNURnp6RytFQUly?=
 =?utf-8?Q?aNb8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5143.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8facf594-4fe2-410c-5130-08dabcac7623
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 08:30:12.8144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zvyZwYAqqOYip5HSG82o44vQcmsZQOiyHZO0sjo/V1u66aipkAxB/SuLUzF8KXVSCqbqG/XQxWSkiiDyjt4s8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5413
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

VGhlcmUgaXMgYSBuZXcgMC4xMiByZWxlYXNlIG9mIGlic2ltLg0KDQpodHRwczovL2dpdGh1Yi5j
b20vbGludXgtcmRtYS9pYnNpbS9yZWxlYXNlcy90YWcvaWJzaW0tMC4xMg0KDQpOZXcgZmVhdHVy
ZXMgc2luY2UgMC4xMToNCkZpeGVkIE5EUiByZWxhdGVkIGlzc3Vlcy4NCkZpeGVkIExGVCBhcnJh
eSBzaXplLg0KDQpBbGwgY29tcG9uZW50IHZlcnNpb25zIGFyZSBmcm9tIHJlY2VudCBtYXN0ZXIg
YnJhbmNoLiBGdWxsIGxpc3Qgb2YNCmNoYW5nZXMgYXJlIGJlbG93Lg0KDQpBbGVrc2FuZHIgTWlu
Y2hpdSAoMyk6DQppYnNpbS9zaW0uaDogSW5jcmVhc2UgTEZUIHNpemUgdG8gNDhLDQppYnNpbS9z
aW1fbmV0LmM6IEFzc3VtZSBRRFIgc3BlZWQgd2hlbiBwb3J0IHNwZWVkIGlzIDANCmlic2ltL2li
c2ltLmM6IEJ1bXAgdmVyc2lvbiB0byAwLjEyDQoNCkRhbmllbCBLbGVpbiAoMik6DQppYnNpbS9z
aW1fbmV0LmM6IFN1cHBvcnQgTkRSIHdoZW4gcGFyc2luZyBlbmhhbmNlIGlibmV0ZGlzY292ZXIN
Cmlic2ltL3NpbV9uZXQuYzogRW5hYmxlIElzTGlua1NwZWVkTkRSU3VwcG9ydGVkIGJpdCBpbiBQ
b3J0SW5mbw0KDQpBbGV4TWluY2hpdSAoMSk6DQpNZXJnZSBwdWxsIHJlcXVlc3QgIzMzIGZyb20g
QWxleE1pbmNoaXUvaW5jcmVhc2VfbGZ0X3NpemUNCg==
