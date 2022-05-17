Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06BC529C56
	for <lists+linux-rdma@lfdr.de>; Tue, 17 May 2022 10:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242824AbiEQI0n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 May 2022 04:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243219AbiEQI0V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 May 2022 04:26:21 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2111.outbound.protection.outlook.com [40.107.21.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8559CF44
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 01:26:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grWb1x94hnL1Ow/ZN0Fp2aS32m1YMZnP0dK1N5dBkmAGuEnSD7TWb0Y6e+GCfM8oixOukzdIIty/sinBA27Z0sPYqTPdzZNeRgzwhuzh/agvNS22g4F/Yc8v8OWQxPcU3RP8t72T/oawrZN2EsHAjnAIpia0+59xDR9RVQu+YpfvK+R+zCr9lngQneyhk0S6zwLP+lC8hOF9pRFIRsdAnohJblDcMLnpQaCWQ7mti1iwDlBdERNLA0dOtEDhvWrGR9hm2OIaMc6yhdVGM7nXMbbYbQVV9V1aZQnoIAUmnX6BLgFLf4SAB31Nmd2iyaaK3XIGgLw+bmqZYELfJIyAPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTydxOd4MK01cIS5pHAC0ZEWg2LxoVbuFewDC78x/U4=;
 b=h4MgFCFDQhUtVQiWSyGQ7gv1HfnJdm/eYMRRydODORNKqd7ivInayISj/hVv8Z4cgLQoJ5V/GJeaFXNqROS0ojfEAySmueLeCYa+6xVxie5IAX2bGfTxMQ0kcnooKCKndJcQ6aYWnQF5ZCbm9lHOkR0NtSuWrP4YyRX/RQ3KeAHSK14yGW6DgjZfjIJIMBP9DQR8+8qM46Int9GNAw754Uf8N2gMaxQaDMMmtK+94SRE4z5Fk6mB+9LzjBC4+FuBoTXDlniks/JGpJcR8I5hIrEgldfnxYJh8/bfXbtaqgUCIk2U3hEpt6bgovkUhWMh5MEWaN6vfRfcMq1+WV2WQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=primelogic.nl; dmarc=pass action=none
 header.from=primelogic.nl; dkim=pass header.d=primelogic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=primelogicnl.onmicrosoft.com; s=selector1-primelogicnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTydxOd4MK01cIS5pHAC0ZEWg2LxoVbuFewDC78x/U4=;
 b=VkWknuAhzDDYpDvP0+4ky5BBl4RDc3Vu4x1ptVJqc7NKg50znFguRPh77P/7MbXlRUwFkdroHmvxNLE8ZSUBDhyMjTmmzh4A0N9HF6EQ4lCwILQZqrK+/Y7TxIv1Nn93+NUi8dVPVtp+dV8Fr2Em9fobpDI0BHTY9BOBLNRQsJg=
Received: from DU0PR03MB8162.eurprd03.prod.outlook.com (2603:10a6:10:351::22)
 by VI1PR0302MB3184.eurprd03.prod.outlook.com (2603:10a6:803:17::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 08:26:15 +0000
Received: from DU0PR03MB8162.eurprd03.prod.outlook.com
 ([fe80::543d:8c49:f7f6:6be0]) by DU0PR03MB8162.eurprd03.prod.outlook.com
 ([fe80::543d:8c49:f7f6:6be0%7]) with mapi id 15.20.5227.023; Tue, 17 May 2022
 08:26:14 +0000
From:   Mark Ruijter <mruijter@primelogic.nl>
To:     Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     Kelly Ursenbach <Kelly.Ursenbach@eideticom.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Lee, Jason" <jasonlee@lanl.gov>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Logan Gunthorpe <Logan.Gunthorpe@eideticom.com>
Subject: Re: Error when running fio against nvme-of rdma target (mlx5 driver)
Thread-Topic: Error when running fio against nvme-of rdma target (mlx5 driver)
Thread-Index: AQHYHRbxB1j8kCqLyE+mphWtfDRQH6yK53wAgAKPR72AAMXqgICVOjWA
Date:   Tue, 17 May 2022 08:26:14 +0000
Message-ID: <3F2D3249-79E4-4CE1-940F-E1E0719EFAF0@primelogic.nl>
References: <MW3PR19MB42505C41C2BA3F425A5CB606E42D9@MW3PR19MB4250.namprd19.prod.outlook.com>
 <62fd851d-564e-e2f3-1a40-b594810d9f01@nvidia.com>
 <MW3PR19MB4250DFC4E2AEB8184299A4BBE42F9@MW3PR19MB4250.namprd19.prod.outlook.com>
 <a0d3b1f7-986f-591d-2675-8ee753d2e7db@arm.com>
In-Reply-To: <a0d3b1f7-986f-591d-2675-8ee753d2e7db@arm.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=primelogic.nl;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 754e08ad-5ad2-486f-f8b6-08da37dee83a
x-ms-traffictypediagnostic: VI1PR0302MB3184:EE_
x-microsoft-antispam-prvs: <VI1PR0302MB318402DF641E2221B8015280D1CE9@VI1PR0302MB3184.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NVSDJPt2YROWAbnDugxzyXk8GCOmpfyBR29lWlaRTJLc0fA0SxN3GF/h+ydfPMDVprwaYTpXqiCGFO7Y28WIYa0AL4ON7/WNXyzjOYnus2TWr7BSK2zJ1hHFIUtONAlw2LRUo/P8uEloNWHFpGIXVhCa4fLkQ6viSlz0aIyc9oZDfsmiw906AHSoZWoqcN4sqwQJC1+3RWG5S+QOmVnjAoKLVskcBjxgkp+O1iXRx94bWaTomUSpTpHIeVtHphvDyy/fPqLvWSOadVMNoerxTH1I7Ha4qBBBVOBtvmA2A4Ii6asGfY89FfUCGVbZ+m+pg8oV483DXS+w1RQKxjGJX+mox8nmWboCZ+lgd9axm+Ua6OyK9Sunif9SFNg4zkj7gZD+gRlB4eU+sgRM/pkryVJwKZ/SqsKZN98DjPhMIB+GiIwALPRPmyl1TifggWnlKiYn6xg4ozoTe0/M01tVJW5kKus1IGwU9rI4gTJXisZagd7FpRicj19YPGzbtKIRvBCH/zlZMtNa2iac5nvA6BgPngdkiKofV6jCMmKNyceGk1o/pCZ0AeunZXsJPF2JAiu1EQg4u+xlkCXcNjF72ajPMXe2lsQqY4Ix3wsqGhw7ONTdK9m8YYEwF3uHWYxeCfway3WWqxb/V9Vkw0Zm3ksw9GGgDrdFmLJFi87fcZuhfCMcCn9DB1lKqEXBY+qDy8gzv8cDw3xpRaNGV0/lg9VWmApWOgF0K1Yr9vXXn9tSxB9eN3PXJ8C9wV1AQqgBIF0Rf5grSfSqtR905xhyAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR03MB8162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(346002)(376002)(396003)(39830400003)(366004)(83380400001)(66946007)(76116006)(64756008)(66556008)(186003)(2616005)(91956017)(8676002)(4326008)(508600001)(41300700001)(53546011)(110136005)(33656002)(6506007)(38070700005)(26005)(86362001)(122000001)(6486002)(71200400001)(2906002)(54906003)(316002)(36756003)(38100700002)(6512007)(66476007)(66446008)(8936002)(5660300002)(45980500001)(505234007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXIwMzJzYUU4aEovRE5JOGZ6R0dkdXJGN1VCY0gvQjVObFhBNzdoS204TEE3?=
 =?utf-8?B?c2V0RW14TStkVDRQeHk2cysrazBZeVRFU2szTHRLTW5HeWFWaDhIbStNakpN?=
 =?utf-8?B?R3ExY1liVWRaQXlSOGNHK2pRb2QxaU9tQWU1cU9pRXQ5NFJkN25aU2g2eFJy?=
 =?utf-8?B?ZkRtME44QWNNMFYxRWdhY1JTYy9UbkR6QW1FSDhOM2JGNDB3QkFDcmdicWU3?=
 =?utf-8?B?NzAzVFg2TlVGRmpLaGh0eUU5dWxqTFpOL2NIYzBSczlhdzlGUWU1MGFHM0ZW?=
 =?utf-8?B?SEowVVY0NUwxTmF5RHdQNE1KYWlzb0ZMMmhxbmVaT3Q2ZEY4aUJhSm0vUDlq?=
 =?utf-8?B?SVNRUmZDTEhnR3RUc3doOGVFelN5OHhHQk9hNURrOWVqY1hLZlcwSExveTFM?=
 =?utf-8?B?VHNlcVJDTjNkdXp5UE9EdW5Lcm9UeXJhbUF0US9xZmdoNWYvM0RxT2dqamdr?=
 =?utf-8?B?NjVaaEd1MkRXalAxV3Z1am9WbG5YVDVXOFljQlhhU2RZbEoxdFgvZ1ViRnVP?=
 =?utf-8?B?eTRNYURHNHpNN3BYUU5Hc2tRU2RySWpPLzdFdzhwOTR1RkY3M1JvRzA0eGhR?=
 =?utf-8?B?czcva3E2OFgyUWR2ZjdlRjFraUwvYmtiYnZlSm9jaTVBa05NbUZmYjhtNHVT?=
 =?utf-8?B?ODEzYldvL0dvNi9ZTVBsekEvUG81WGc5bVBBa1cydE90dlBGbDB1WVhFVXhB?=
 =?utf-8?B?MHpQZnhvTmJJK3hBaXcxTzBFYWl5ODRmZUJpOXJVWXFJbHNaMGpGSyswdmp0?=
 =?utf-8?B?VXhiU1Y2WlZrS2dCU3lPYkRUSE5jZTN2Q2llTS9CZk5CWm5jbmxVMTVPMHgy?=
 =?utf-8?B?ejhIUlVVbFVXNm96ZDl3RnoxOVg5ak9Ub3BjbFhaUjZ1WmY1RzA5VmFveEt3?=
 =?utf-8?B?aEJkSEh0a0xzNzFXN0FyT3pyak9PYmovRktlUmZtN2lRb0lYa2poY1dITlRH?=
 =?utf-8?B?OUFpczNmS2VNaGR6WTREZyt6RTBORXM5eTdNT2hjdjIrMXVJR2lpb1U3RDNh?=
 =?utf-8?B?a3RrMWE3SW1CVmZKQVhZd0dLTkV6V1hrVEZzbkdEQUdOVkNUSnovQWxFQjcy?=
 =?utf-8?B?K3JObC8rOUY3TTNyZFRjT202TUZYS2VqU2E3OFFmYjNTUDIya0pRTW16RDRj?=
 =?utf-8?B?ZTBnMjBFTGhkcVRJTDBuNVljTTM4Wk5ENHQ1QmlNUmcyaHY0dWlMeU41RlNy?=
 =?utf-8?B?N0FiWS9ReDJYS3YyYk1OYVIrMVMxZlJDeS84UVVZWE93dXJocm1uSDVSRGJx?=
 =?utf-8?B?eWJwaWJCRDZSd2VOM1JsV1IwVzc4QkRvbEVHMjQzeTM5VHRJT3R3bTdQQTV0?=
 =?utf-8?B?U1VtNWk3b3JEWW1ESjhxY1FscGJLbkVXK2lBblgyWjJZaWJOdjkvdzhLb0I3?=
 =?utf-8?B?aHovTGFkY0w2YmZQd2g3K0JYNmhWVEtWQlRLSWxlVTNLeVpOc3lDazdIZURa?=
 =?utf-8?B?RFcrOVBqaVlvSXFycHdIckFwV0c3L2l3Ym4yN3U5c2VvK1ZiL1VEbUFPTytU?=
 =?utf-8?B?WDd5NDk3TXloU2xKbnVkdVVOWnJEbzhYL3JQTkZ4bHJSMnVQaFlWVkExd3pU?=
 =?utf-8?B?T0RPUE0xOW5FMkhmd3djMmgzMGxWek53SVgzcEZsZnE3TkdPazZxN2h6MUQx?=
 =?utf-8?B?bks4T041eE9Bd2Q5YzhuaXYza2kzWE5DamNXUWN3Z3dvS0kyYXZFZjVtSFM2?=
 =?utf-8?B?UDJBWGladW5hS1BKcGZHTmFRdXVid0NRVzRLbmdua2ZXeGVaY3JYRXZtZVls?=
 =?utf-8?B?dWgzTGxKbkV3NDlQRndXQzRYS2ZWOG5OUFpudDJySytibit2VkpxYVdXZFlQ?=
 =?utf-8?B?czJmajZ0WkhQVksyTEYxMytaRXIvdDJ3eGVMbXp1d1o5dU5vVkJya0FXcWZZ?=
 =?utf-8?B?dll5L01rNk5iTUNmeHR2amhqS3VWYTNDUWRiakNpT2dqZUFZU3pZcjBGUHNQ?=
 =?utf-8?B?blErRDVmaC9FOXZsRVRhVEloVDcxTHJJY3NSTjdaMENlU2RNTjQyeVIrZWhW?=
 =?utf-8?B?eVhMR3FqNURpZVpYTnBzRzRlRjlGdCtYeWdXaGhxWlB2TEZNMXgxa3ppR01K?=
 =?utf-8?B?R3lKQ1BKZUc3bVpDVEdIczVha2Q5S2ZuNEdoTmR5aFJRTUt4c0pXTDc1bTQr?=
 =?utf-8?B?T1ptZmlGbTJ5a0pPalhXSXQ3cmViYkp6bHZ0VnFsNnhMbTFYWEFyeE50cTdx?=
 =?utf-8?B?U1k2NTRaTFdiN0RDNkZQSkxxRXhyOTQrNDFGU2ExVWxlcER1UDUwUUJQOFFo?=
 =?utf-8?B?WkVhbDkzS0xkZHFBWm9zcnZEL1lpRlZjakVOVHZ0WkpsZHFjWDllR21QTGpD?=
 =?utf-8?B?ZXFaUmN1UU1NYXEzMHNGeXM4alE4YzdabXZ4Z1Z3SUNldGg1UW1ZL2J2ZnRl?=
 =?utf-8?Q?KrxE6W+L/gmmVr0s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B7730CA8DAE734A91E17CA89F392764@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: primelogic.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR03MB8162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 754e08ad-5ad2-486f-f8b6-08da37dee83a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 08:26:14.4324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6f00f2a-c615-4e27-aa0e-cb78655623c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kNJs/7ntsrPoG4p1mklr+PocUr98wNjRFUifQRxODiJEPjJ6kzyivf+EE++Ri3/eoPy0cUIVpT6d0nRyxOMDPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0302MB3184
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgUm9iaW4sDQoNCkkgcmFuIGludG8gdGhlIGV4YWN0IHNhbWUgcHJvYmxlbSB3aGlsZSB0ZXN0
aW5nIHdpdGggNCBjb25uZWN0LXg2IGNhcmRzLCBrZXJuZWwgNS4xOC1yYzYuDQoNClsgNDg3OC4y
NzMwMTZdIG52bWUgbnZtZTA6IFN1Y2Nlc3NmdWxseSByZWNvbm5lY3RlZCAoMyBhdHRlbXB0cykN
ClsgNDg3OS4xMjIwMTVdIG52bWUgbnZtZTA6IHN0YXJ0aW5nIGVycm9yIHJlY292ZXJ5DQpbIDQ4
NzkuMTIyMDI4XSBpbmZpbmliYW5kIG1seDVfNDogbWx4NV9oYW5kbGVfZXJyb3JfY3FlOjMzMjoo
cGlkIDApOiBXQyBlcnJvcjogNCwgTWVzc2FnZTogbG9jYWwgcHJvdGVjdGlvbiBlcnJvcg0KWyA0
ODc5LjEyMjAzNV0gaW5maW5pYmFuZCBtbHg1XzQ6IGR1bXBfY3FlOjI3MjoocGlkIDApOiBkdW1w
IGVycm9yIGNxZQ0KWyA0ODc5LjEyMjAzN10gMDAwMDAwMDA6IDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwDQpbIDQ4NzkuMTIyMDM5XSAwMDAwMDAxMDogMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANClsgNDg3OS4xMjIw
NDBdIDAwMDAwMDIwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMA0KWyA0ODc5LjEyMjA0MF0gMDAwMDAwMzA6IDAwIDAwIDAwIDAwIGE5IDAwIDU2IDA0IDAw
IDAwIDAwIGVkIDBkIGRhIGZmIGUyDQpbIDQ4ODEuMDg1NTQ3XSBudm1lIG52bWUzOiBSZWNvbm5l
Y3RpbmcgaW4gMTAgc2Vjb25kcy4uLg0KDQpJIGFzc3VtZSB0aGlzIG1lYW5zIHRoYXQgdGhlIHBy
b2JsZW0gaGFzIHN0aWxsIG5vdCBiZWVuIHJlc29sdmVkPw0KSWYgc28sIEknbGwgdHJ5IHRvIGRp
YWdub3NlIHRoZSBwcm9ibGVtLg0KDQpUaGFua3MsDQoNCi0tTWFyaw0KDQrvu79PbiAxMS8wMi8y
MDIyLCAxMjozNSwgIkxpbnV4LW52bWUgb24gYmVoYWxmIG9mIFJvYmluIE11cnBoeSIgPGxpbnV4
LW52bWUtYm91bmNlc0BsaXN0cy5pbmZyYWRlYWQub3JnIG9uIGJlaGFsZiBvZiByb2Jpbi5tdXJw
aHlAYXJtLmNvbT4gd3JvdGU6DQoNCiAgICBPbiAyMDIyLTAyLTEwIDIzOjU4LCBNYXJ0aW4gT2xp
dmVpcmEgd3JvdGU6DQogICAgPiBPbiAyLzkvMjIgMTo0MSBBTSwgQ2hhaXRhbnlhIEt1bGthcm5p
IHdyb3RlOg0KICAgID4+IE9uIDIvOC8yMiA2OjUwIFBNLCBNYXJ0aW4gT2xpdmVpcmEgd3JvdGU6
DQogICAgPj4+IEhlbGxvLA0KICAgID4+Pg0KICAgID4+PiBXZSBoYXZlIGJlZW4gaGl0dGluZyBh
biBlcnJvciB3aGVuIHJ1bm5pbmcgSU8gb3ZlciBvdXIgbnZtZS1vZiBzZXR1cCwgdXNpbmcgdGhl
IG1seDUgZHJpdmVyIGFuZCB3ZSBhcmUgd29uZGVyaW5nIGlmIGFueW9uZSBoYXMgc2VlbiBhbnl0
aGluZyBzaW1pbGFyL2hhcyBhbnkgc3VnZ2VzdGlvbnMuDQogICAgPj4+DQogICAgPj4+IEJvdGgg
aW5pdGlhdG9yIGFuZCB0YXJnZXQgYXJlIEFNRCBFUFlDIDc1MDIgbWFjaGluZXMgY29ubmVjdGVk
IG92ZXIgUkRNQSB1c2luZyBhIE1lbGxhbm94IE1UMjg5MDguIFRhcmdldCBoYXMgMTIgTlZNZSBT
U0RzIHdoaWNoIGFyZSBleHBvc2VkIGFzIGEgc2luZ2xlIE5WTWUgZmFicmljcyBkZXZpY2UsIG9u
ZSBwaHlzaWNhbCBTU0QgcGVyIG5hbWVzcGFjZS4NCiAgICA+Pj4NCiAgICA+Pg0KICAgID4+IFRo
YW5rcyBmb3IgcmVwb3J0aW5nIHRoaXMsIGlmIHlvdSBjYW4gYmlzZWN0IHRoZSBwcm9ibGVtIG9u
IHlvdXIgc2V0dXANCiAgICA+PiBpdCB3aWxsIGhlbHAgb3RoZXJzIHRvIGhlbHAgeW91IGJldHRl
ci4NCiAgICA+Pg0KICAgID4+IC1jaw0KICAgID4gDQogICAgPiBIaSBDaGFpdGFueWEsDQogICAg
PiANCiAgICA+IEkgd2VudCBiYWNrIHRvIGEga2VybmVsIGFzIG9sZCBhcyA0LjE1IGFuZCB0aGUg
cHJvYmxlbSB3YXMgc3RpbGwgdGhlcmUsIHNvIEkgZG9uJ3Qga25vdyBvZiBhIGdvb2QgY29tbWl0
IHRvIHN0YXJ0IGZyb20uDQogICAgPiANCiAgICA+IEkgYWxzbyBsZWFybmVkIHRoYXQgSSBjYW4g
cmVwcm9kdWNlIHRoaXMgd2l0aCBhcyBsaXR0bGUgYXMgMyBjYXJkcyBhbmQgSSB1cGRhdGVkIHRo
ZSBmaXJtd2FyZSBvbiB0aGUgTWVsbGFub3ggY2FyZHMgdG8gdGhlIGxhdGVzdCB2ZXJzaW9uLg0K
ICAgID4gDQogICAgPiBJJ2QgYmUgaGFwcHkgdG8gdHJ5IGFueSB0ZXN0cyBpZiBzb21lb25lIGhh
cyBhbnkgc3VnZ2VzdGlvbnMuDQoNCiAgICBUaGUgSU9NTVUgaXMgcHJvYmFibHkgeW91ciBmcmll
bmQgaGVyZSAtIG9uZSB0aGluZyB0aGF0IG1pZ2h0IGJlIHdvcnRoIA0KICAgIHRyeWluZyBpcyBj
YXB0dXJpbmcgdGhlIGlvbW11Om1hcCBhbmQgaW9tbXU6dW5tYXAgdHJhY2Vwb2ludHMgdG8gc2Vl
IGlmIA0KICAgIHRoZSBhZGRyZXNzIHJlcG9ydGVkIGluIHN1YnNlcXVlbnQgSU9NTVUgZmF1bHRz
IHdhcyBwcmV2aW91c2x5IG1hcHBlZCBhcyANCiAgICBhIHZhbGlkIERNQSBhZGRyZXNzIChiZSB3
YXJuZWQgdGhhdCB0aGVyZSB3aWxsIGxpa2VseSBiZSBhICpsb3QqIG9mIA0KICAgIHRyYWNlIGdl
bmVyYXRlZCkuIFdpdGggNS4xMyBvciBuZXdlciwgYm9vdGluZyB3aXRoICJpb21tdS5mb3JjZWRh
Yz0xIiANCiAgICBzaG91bGQgYWxzbyBtYWtlIGl0IGVhc2llciB0byB0ZWxsIHJlYWwgRE1BIElP
VkFzIGZyb20gcm9ndWUgcGh5c2ljYWwgDQogICAgYWRkcmVzc2VzIG9yIG90aGVyIG5vbnNlbnNl
LCBhcyByZWFsIERNQSBhZGRyZXNzZXMgc2hvdWxkIHRoZW4gbG9vayBtb3JlIA0KICAgIGxpa2Ug
MHhmZmZmMjRkMDgwMDAuDQoNCiAgICBUaGF0IGNvdWxkIGF0IGxlYXN0IGhlbHAgbmFycm93IGRv
d24gd2hldGhlciBpdCdzIHNvbWUga2luZCBvZiANCiAgICB1c2UtYWZ0ZXItZnJlZSByYWNlIG9y
IGEgY29tcGxldGVseSBib2d1cyBhZGRyZXNzIGNyZWVwaW5nIGluIHNvbWVob3cuDQoNCiAgICBS
b2Jpbi4NCg0KDQo=
