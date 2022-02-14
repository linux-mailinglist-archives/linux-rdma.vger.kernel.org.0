Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F3C4B4E4A
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Feb 2022 12:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbiBNLZe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Feb 2022 06:25:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351203AbiBNLYx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Feb 2022 06:24:53 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2536A065
        for <linux-rdma@vger.kernel.org>; Mon, 14 Feb 2022 03:01:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2atYT86El7kJyKa3kBWI4qiWjGQoO9pcdu3TUdT/6ukI5XNF2u2CEG8YOKmRf+o3dNrRoj1iGzMjI329BSphIj3YQP2l7gNHnScguryrvx38Voepc8H99KGcq+dzRQf0+cE0nYI+FgbKA0zCQ+F26EIStHR1P+wOGVzsi6VY0ZeGSA23vXpabHTpG56Gu6Weyd+ecMsjpo/xqB69wTf5Dw3YbvGwbzrGujT1NyRQO97pxMPh5CuoqOAEV4vHnFV5i7hyNu60rk6eHfjBtCmB34mK9eMMdvPmh5lIMuNmUGJZ0vJbUFuGd6h+eF6LJbwYf+fpFBqpfKd+ftAlJr7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jx7CJdJxOCGRjkK2jIwpPGr7o/iEMlLqFXLh6YkyG3Q=;
 b=W0X5mglfmTaZpYrW2u+0iIG7ZRII8HpseM4fTSCYV/rUgR1fMSbE6EjqV88gVC8nRjxdcCcX3mEnKFeT2VOzccJO6gc3sQUOXDEmGwi4PtNbcXxrHBOpBNte16A9TfiS3yrpL4lLBFe87EMsPahHkJtIUf/r4Qu1KP8qy4gkY5QSZrrUGO8Sq3lND52VGAdXFaOuO2OMmkm1P1jbiz2s5dTQf9CS9weKln404YXrLCzzHAVwrAc2tJbWdsepov1dJHEe0GLaxfORBv2WeXU9zYzHblSfu0dhfAM9fBsVCT4ZrTucKa2coE1KlyLWB/hDYitzrq4z3F14T6Tec9kxFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jx7CJdJxOCGRjkK2jIwpPGr7o/iEMlLqFXLh6YkyG3Q=;
 b=B9X7M4Jhee9A4bzJRrL6AeRoIgaLFvWMMhB7ftqBl+BKBa4/mNuZznHSGk3mr85zEaHH5vunr3dxQ7SgGDb6dcxgLbNBzAolytuyosvtgLWjyqTqWthb48/kR8en2BFCaHwUofjo+ML2MUXzhKnga/HbVMiEiy8sYqaVRxrxtzutRSEp0GGJUi6n36r6m+eD/BfXr9ynO3ldQmQId49GxYz7d+ZdOJZRMthkYFOjZJAXbAjBRw3m5oBvQrmPSnJxo3ZZv41l2MB0aFS+XME5ehJXOEFqEwUegswndYgr59zYuXaSsxQJllmWPKLDac5nr14ijpBHqLsWSeqWSriOpQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB3501.namprd12.prod.outlook.com (2603:10b6:208:c7::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 11:01:00 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Mon, 14 Feb 2022
 11:00:59 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     Haakon Bugge <haakon.bugge@oracle.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
Thread-Topic: [bug report] NVMe/IB: reset_controller need more than 1min
Thread-Index: AQHYIZFNCFKzE02sJ0KTukBbo4Us+qyS4ScA
Date:   Mon, 14 Feb 2022 11:00:59 +0000
Message-ID: <4d9f3b17-52ed-46b4-a47c-a916ec9dd076@nvidia.com>
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <9f115198-bafc-be4e-1c90-06444b8a37f6@grimberg.me>
 <CAHj4cs8wBwDGhhtEPodyBdR-sCqJLYhwLhNHuPDm+KCan0hwWg@mail.gmail.com>
 <42ccd095-b552-32f7-96b0-d34d46f7c83e@grimberg.me>
 <CAHj4cs9EazUmtbjPKp5TXO4kRPcSShiYbhmsHwfh7SOTQAeoyw@mail.gmail.com>
 <c6d43a10-44bc-e73a-8836-d75367df049b@grimberg.me>
 <162ec7c5-9483-3f53-bd1c-502ff5ac9f87@nvidia.com>
 <CAHj4cs_kCorBjHcvamhZLBNXP2zWE0n_e-3wLwb-ERfpJWJxUA@mail.gmail.com>
 <3292547e-2453-0320-c2e7-e17dbc20bbdd@nvidia.com>
 <CAHj4cs9QuANriWeLrhDvkahnNzHp-4WNFoxtWi2qGH9V0L3+Rw@mail.gmail.com>
 <fcad6dac-6d40-98d7-93e2-bfa307e8e101@nvidia.com>
 <CAHj4cs_WGP9q10d9GSzKQZi3uZCF+S8qW1sirWZWkkHuepgYgQ@mail.gmail.com>
 <2D31D2FB-BC4B-476A-9717-C02E84542DFA@oracle.com>
 <CAHj4cs-yt1+Lufqgwira-YbB6PHtJ=2JA_Vora_CfarzSzoFrA@mail.gmail.com>
 <4BB6D957-6C18-4E58-A622-0880007ECD9F@oracle.com>
 <CAHj4cs_ta5WR7j0qvHyr1tSCR-U7=svY5j8Hctd7YUMNcGXsaA@mail.gmail.com>
In-Reply-To: <CAHj4cs_ta5WR7j0qvHyr1tSCR-U7=svY5j8Hctd7YUMNcGXsaA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ba6d497-f079-437f-4b7a-08d9efa94874
x-ms-traffictypediagnostic: MN2PR12MB3501:EE_
x-microsoft-antispam-prvs: <MN2PR12MB35014F0CE41AE73501266D73A3339@MN2PR12MB3501.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dukGXpbw8joJwXEZ/ZE+6GNnzwkaD54k521UjYRyeOVd4WF+YrmquCmnXlIGzEhyUfCNMNagWF/ZDynmm+t2uQ1AR1Um2SMCo3/Vi3C3QfmtWQocWwaX6hnzYTlw2OwDCmIwnuX0+WQ9orC8FuiCM7zu8R0mVfsRzT6uulxA/I1g74d+r2XWrnaKOaJa+k5aOsOXPViMaXRbSm5/UJpsagvFriy724fKCBgt6bYjqMNhF2hF0wQ6AQY5ZNJd9EG/6HtkGuGwavm95q3RNvfLwbHJ0H6JBL9eGPPYlVbj5podXrkP/ZpgjXsROz9/5uCZvgKxiOs7+a8RULKxxzrb6PCkls8hWrUl9V1+0JUrRzwrk9ncfUT+4LKVeKZGCUKdkaflJVdXxBx6ZM3iJ+S//6NaztPMgCshEDnwcle1Ycpo1L6pSpqWoQZ1GRiovnPVKEuhY1kZVgUyWojb7G70jZ3aKfT2HF94M3lS4xfLGbmKD2jWQQZaWE62KIpkpI+CaQv925bexfczgS3nC1EifMoH1vhaKuB6YFK0RwDqpIuyc9otJIF+kEUOTGxkR+Hqus5FeRqJFuTL2Bhn0zoc8Axoc9twJR1ZIqHNulPUuHaw7MsRgtlgWMDJZ3vWq+PkD456V0ViomgdY4OBcMRCqvNy97hYyeOMMBXHLkseGfR505MRKV/8z7AWBOhrzIxnWb21GqdEn1WpmrgNkfVyb0uf7AAShII2dHAB/ju7kNQINE8yE05jrGdACsm94Okm+WDLD3Bu0sAr0gvNfVbF5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(31696002)(8936002)(2906002)(186003)(31686004)(316002)(38070700005)(54906003)(6916009)(36756003)(122000001)(6506007)(53546011)(6486002)(107886003)(71200400001)(6512007)(4326008)(5660300002)(86362001)(2616005)(91956017)(508600001)(4744005)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTJCbmF1d3BnQURLQndWSGZTdXRTai9iU3Z0Y1dyK0NBZEhDZkhaTlpESFdy?=
 =?utf-8?B?aytGY29zL3VOa0tYN2hGblptNVBGUWlGRUZLTnRoQ2J4TDBUSjZOOGZnTWJj?=
 =?utf-8?B?Sm80UmQ5QVk3ajlOOXhsdkZKSytsdzBBamtCMFpRNDk3ODU2S3lsVUhVeXBr?=
 =?utf-8?B?VkR2aE1IMkJBS2NMWXg2S2Rhc1hjWW9ZZGNQV2oyZU13SytUMjRsZVJ4V0F5?=
 =?utf-8?B?and2Q0RnckNSOHRzNnNVYWtvdml4QTd0ZTl3OGhhTVVPWEwwS2xlVWdpdXZm?=
 =?utf-8?B?dnR3c1VrZDF1aVNmQmxjWHZhTXJiUy91eEgwRmNZUy91aG1PcjVodExxVWgx?=
 =?utf-8?B?RG41Qk9PcGZ0b0hMcEVCd1o4UXlGWUNsd3NiTVpscm5zSnIvVEk0MGdlMmI2?=
 =?utf-8?B?MlE5TU4vTTJJalNkNitqcEQ0UFFlMmlsR1FuR1krOUEvN0orcDlTejk1cGc4?=
 =?utf-8?B?WVlnZXpqNWw0UXkxTEsyOHBBZUE3czdQdEo2YXlhT2pyaHFUNDlIaHFhUTFo?=
 =?utf-8?B?U2VGOHZMQlNCTnZWS0hGUUd4dlc0TEVhUnlERjF1bUFRdGc0aHIrSC9HVDBO?=
 =?utf-8?B?RkVlVExycGFoVDk5cWRMZXcyZ0tRTkxUYzkzajRhU0czU0hnbGJnTkY1UVl1?=
 =?utf-8?B?ZHFITy9ZczljNUljU1U5VkJBSGR0Q0hXWDJ2KytBNi9EZ0VMQWlxbE9aSDN2?=
 =?utf-8?B?MXdwUkJPT0l3KzRMMVBEdXhnYnRGaDRVTWtnN3dXYUN6Kzh2Z0FDYjF3TFFa?=
 =?utf-8?B?TzVTQmEreE1ibyttWlBhcGVSRnoyNUM5bjZGRUdGTm9oSDhkVlJjTXBqQ2Ew?=
 =?utf-8?B?aXJyQ2t0RStSN0lPVzhHd0dRWDRuVWdrWVFHS1poQXgvcGRYZU9aKzVzM0JB?=
 =?utf-8?B?cFp5SDNCNEhpQUlUOUdoU053MGZ5WUp3RzJTRmZLS2hEMzU4UDc5Q3JxdzRP?=
 =?utf-8?B?NHBjZExlNTd5K21iY2tPei9zanJycHpQNFZtbnc1T1d3M3U5bUI5MGZrOTcx?=
 =?utf-8?B?dFR6RU1aQ1h4YlZNWHl4ZjdJd3p3cE1VemJXZjlFOEZ1WlZ6SDRiL3YwZ2JF?=
 =?utf-8?B?amEycUVsdlVTdE9lcHhOTGJkc1N1T2dia205djFNTUN6bDhRa1h1NnlFRndh?=
 =?utf-8?B?V0tyVjMyalFkZ3N3TXdsUGlpWDh0Q0ZqbHovVTRMUjYvYzhTdXliMDBsODA5?=
 =?utf-8?B?UjhSdFQzLzR1RUJvd0toczdxamJSRjcvR1ZEN2MrN1cvOVpSSVhKYkgvNHlW?=
 =?utf-8?B?eXJCOU42a1loYzlHNWRpWHU4Nk0wem1HbEdaRG1DUVpMQzl4b3ZPT0VQajJp?=
 =?utf-8?B?ODJ1YmJtVnlwRDZEQk5vTENmaTRpYzlBVWVRR0pwaFZsY2ljVEVUdEMwMEsw?=
 =?utf-8?B?dUdSR2gvcXZBcFNtbUZqWXNsZUlMSXZnejV0VWV3d1hXZzEzbXJRZnVlUGZa?=
 =?utf-8?B?eFBGY2V0MXFyMVpHMmRjZWdHb0dieHlEMGN4Z2RnQkgvcUh2MmV0SHUvNjZJ?=
 =?utf-8?B?ZklzTEpqM2MxTWVOT081eE94ZWE4WHozRlpRb0xzMWYza1NDTjRaMitvZVNC?=
 =?utf-8?B?YVl0RWF6dWtoejhXQXRNa1N3cmJsM2dJMk5haTlkUmtCQlN5ZFBnODFIblBr?=
 =?utf-8?B?YzVvS2F1ZkgzVjA2dWhLMFBySlpJK1JrRXY4R2doamRhcGhESGJjZW1wWnF5?=
 =?utf-8?B?LzI2YysxdVZ6R2hzZlVNZFZSMHpoYnV1dFFpTGYwS3V2VG4zSXFFQWVua3d6?=
 =?utf-8?B?bkVyY3FCTjl4K1V1anlyMjBZcW56SmFDWktqZzhhZHVtRjI3SjNyMlVlYWpO?=
 =?utf-8?B?U0ljWWJ0clFlTVNTdWNWQnpzTCtMdzlYSnROOVlQbEgzbVI4a2NRemhHWmox?=
 =?utf-8?B?ekJIZ1FJTDRJVXlRUGtsWGN5ZDZiT2YrNitMSFRPdm1FVHFjNFpuNW5UcXZR?=
 =?utf-8?B?d05VZmlXMUtYTm55NzNMbGhBd2JqZ2pRcUx5SDBUaWNHZTJKTUdpUEsyS1Vy?=
 =?utf-8?B?VWt1VUdITzhqYnE3TGRSZUtjKzNiU1RQcVlwMU84eGRGZlVYNVc1OXdXd0cv?=
 =?utf-8?B?WnJmSEd1U0pEd2Jqa1V3d2xLc291cHlkcWUwb1drdjRkVGlKc01QL043RG1N?=
 =?utf-8?B?aXhOQWVsdFFPbkNSclVPZDJZRDBKbVgzZFlWSWVQV1RDUXUyNlVRakQvQlpv?=
 =?utf-8?B?UTU5dThLRlJNMmdaNUtRTXFOekUxZk5BWDJ4UTdTeS9wRk1vRmRlTXVXWmt3?=
 =?utf-8?B?S2dBQnQxM1pET051RlRzbVBVUjFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40ACF72EE50C4849B0A38C25E4B27C86@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba6d497-f079-437f-4b7a-08d9efa94874
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 11:00:59.2634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alov4kgpZe45zcpTjGFm/SOTdbIdzYIwMuY9F5E8M8qlQaAlO1mggEbaOYIDsfSuHoIrR7L17a4SPleWbE3Glg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3501
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMi8xNC8yMiAwMTo0NywgWWkgWmhhbmcgd3JvdGU6DQo+IEhpIFNhZ2kvTWF4DQo+IEhlcmUg
YXJlIG1vcmUgZmluZGluZ3Mgd2l0aCB0aGUgYmlzZWN0Og0KPiANCj4gVGhlIHRpbWUgZm9yIHJl
c2V0IG9wZXJhdGlvbiBjaGFuZ2VkIGZyb20gM3NbMV0gdG8gMTJzWzJdIGFmdGVyDQo+IGNvbW1p
dFszXSwgYW5kIGFmdGVyIGNvbW1pdFs0XSwgdGhlIHJlc2V0IG9wZXJhdGlvbiB0aW1lb3V0IGF0
IHRoZQ0KPiBzZWNvbmQgcmVzZXRbNV0sIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIGFueSB0ZXN0
aW5nIGZvciBpdCwgdGhhbmtzLg0KDQp5b3UgY2FuIGNvbGxlY3QgdGhlIHBlcmYgbnVtYmVycyB3
aXRoIGZ1bmN0aW9uIGNhbGwgZ3JhcGgNCmZvciBiYXNlIGNhc2UgYW5kIHByb2JsZW0gY2FzZSwg
dGhhdCB3YXkgeW91IHdpbGwga25vdyBleGFjdGx5DQp3aGVyZSB3ZSBhcmUgc3BlbmRpbmcgbW9y
ZSB0aW1lIC4uLg0KDQotY2sNCg0KPiANCg==
