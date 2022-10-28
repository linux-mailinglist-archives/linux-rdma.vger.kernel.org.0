Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578C96108C0
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 05:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiJ1Dbt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 23:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiJ1Dbr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 23:31:47 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C7CBB3A8
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 20:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bz6dY+VSGMa4fcdiqJ9dgB7ofz+P74HM0k2uQkSLQ30tKbTDI2JPp/jatfQWlCWVDP3Ma05ufK+pU8RRPcg3jfVb5+0EhkIdRscPup0q05LKymedMQmPjkOse2B2moW0m+h/w56+ahGSiMlANmOz6b9w8UHZMeYYsmKJpFY9D29ivw/wy3AziJSgth/Vz/pufKwPP7VxFNfIprCt4VljPcPh/U4gtLEYt3PUe/ZpDruUSQefsMVl1b/fJNMvWaQ/EISroOM08lHSnAULNQNV6a5eOebPKHtRT7/leXCheIJ0jnEO+1uIr4siobP1HygLPfY0ORD1geZR+PRkoOFevA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkrAEiXxqtcNmfHIPipbzpsDL1oQFb3gjwVwsD9ElYc=;
 b=V+h1QBNeFnOi1E9idA2fqWALhbnx1lWrnYY8T/b8fXPS6TMgqDXgufwFU9g3N+rKiqkzDIfY1yBrvXxs/hcN3EGWnuBVC2stFrAXdL1B8iCIYoMOrsP55nMn5R5Vi7a6o0sZdwqKENBBE0tPr9zdHhI/bl5zqevlbMnYH+lSOHU2KH/CMKFnHBMXmXEPaL+NrKgCSu7SklDE+HHa4VjliNQs7hv9EHRM12d7PGK/MpfJSKF9hXAloHkVCX68/afye95AgLPGfaFK0xncfonNxO5jLZaG5rDoPIx483gtPEIj63xlS+JD6fyL5xJIFoOAYPcGpx0OBHBCpS4JGZgWiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkrAEiXxqtcNmfHIPipbzpsDL1oQFb3gjwVwsD9ElYc=;
 b=c7capor54TRwXj9UydGeFSRk26JF88zCD/z3p9pHV7XmNLZiurUnVDFnsdtkuoiVnzzGGdhLww/AORr4jlDwfIlxOs1M+xLc3HWKIqpU+/TEzZByyThk3B2hiUq2s1QWUB8P3UaWVwnQ8KmWANRS67GqRQJXM0zGD4NKopA6RT9QFSgzq5H3IkLOVClMomY/HDQ7janadgvVTW4JD8l6jkrunOBiq+sAK2W9ZbXuzH85pTIBGl1Oc7aUh0D+4kM3nwkLWjI+T5KnUvngNden8tndriQrV3GX1E67qS0zcIwJB7BKrB22oAsWq+NeotK34zXTAoSc/YK5bx7Kj8tO3w==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:212::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Fri, 28 Oct
 2022 03:31:45 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e%9]) with mapi id 15.20.5769.014; Fri, 28 Oct 2022
 03:31:45 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        "dust.li@linux.alibaba.com" <dust.li@linux.alibaba.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 0/3] RDMA net namespace
Thread-Topic: [PATCH 0/3] RDMA net namespace
Thread-Index: AQHY5qHU4bwCU56Yj0mBzA3dKbf6464gylCAgADAs4CAAAgm4IAAAiCAgAAAI1CAAAKNAIAAAC4AgAAF6oCAAAAm4IAAJ6kAgACEhgCAAOEMgIAAALIA
Date:   Fri, 28 Oct 2022 03:31:44 +0000
Message-ID: <PH0PR12MB548174B0CD9E7DA82DF9F25CDC329@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <PH0PR12MB5481AA6E4D5BBAC76E027458DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB54819EFE62D489FD489A307DDC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481D39B0CD65746C9808046DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481F98B1941FA63985D13E0DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20221023220450.2287909-1-yanjun.zhu@intel.com>
 <20221026150113.GG56517@linux.alibaba.com>
 <20221027023055.GH56517@linux.alibaba.com>
 <5314ed2c09c1336f5c21cf7c944937e4@linux.dev>
 <e2e3bc30862d0f6b2fc8296624527e0c@linux.dev>
 <6d841d006c9a79d9ecb1b1bae8d10a28@linux.dev>
 <7f5ed21ac410646aba93aac875a0d8a8@linux.dev>
 <PH0PR12MB54811A129A037D716BFD934CDC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ddd5fb94-127a-0fc2-cadf-7a0f24fa0d15@linux.dev>
In-Reply-To: <ddd5fb94-127a-0fc2-cadf-7a0f24fa0d15@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB6657:EE_
x-ms-office365-filtering-correlation-id: 54788528-c8a8-4109-0497-08dab894f02b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /7n9bVj2ORTolpxX24m8IoHcZ7Yz7y3oFgjW9DBqmAtsk0haqdL/WLPt/bNPq+qexNcFw1+4myi5RTbRYntnSPqzg7r3k7fytEYraM6kteZnzoCLxapvsbwUxhkVRKQKZssbEtgO4RmzOMaIRnZ7Ju+vAoLn2c0B+NYrdiN4yvj76oWarejQgR0K52uCYRL7mG4PsE4e+DSiVtyd5jqYEQe77yAGOh0/Na6SFcQSh/p4vYHaf0qP7uJU2NlJ6IHlJPJUhA89vtjSbDr2xjrta18XeLbHuDgUoP5DI3+Y1mwQ1lMtdG06PJXu2T53wHOZyj+dbzIb1Qp9Kq672qav2jWhwfVKSbhepqSlCJY8dWhCLn45x6xCBCv4gXmFi2GR6yRH+/NrnIrDy5uIirUTSYLekxUq/951U2pVXgV9STI0AhMO41PAfMmStQosv5L5ZYqqLJb0S2XtoQu9WMbTqF/3gnStRwRcdswToMaa4JlmLzo1iJYBosIfkvPFih9lhsd+kxvxOKoaq5ummFyVPk32BUkWt+LdMTW/xIFRRInBGlqx21CknCby5mti8E8ummBx39PwmnsTQXO3rNWfUn+P2CUe51Nkzfmw5vva//sDSDr8AGpkN0yuqOZj3bMIEdW9SYT0nwT9gSiI2ZwWtBZmOVzj69Yx+JN0R0+Gs9It3Dy0ahMSgvQxi5/fNmpl9Vg4EOojn0sNbTXNs4jpFDWfwsmuQbydIB/aqm3q8li6GUIf7doH2sHKYOcm7PQKlLOuiNgkVhpGkG9PVVjFMAAWcG18mobNs5IAYW0Iq9J46GmVQUrzoaP494in15LnIl2DIZH8zpUbX70YE4uOv4iWy6jU2Z/tQxhfLASsWF4bIMKZZ0Hcc4bfwztyuSPD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199015)(66946007)(33656002)(186003)(38100700002)(38070700005)(2906002)(316002)(55016003)(7696005)(66446008)(53546011)(122000001)(110136005)(86362001)(6506007)(26005)(64756008)(8676002)(66476007)(9686003)(71200400001)(66556008)(478600001)(52536014)(76116006)(5660300002)(8936002)(966005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGZFeW5mNjJmUnE2VmZjNFE1M3kweUxQd3RRcnRtMkR1U21oUHBpelowWmtn?=
 =?utf-8?B?aGNzM1BXN1ZrY3R6bUZQSlhlTzlLNEh2R2F3TVZnVW1OU3AzOE9sWmM0OWJa?=
 =?utf-8?B?Z3UrbDVGNElWZmcyd3YrRDZVWDNNcjdETUI1ZW1CU2xPajZreDF6YzhwZktN?=
 =?utf-8?B?TnYzKzYrSFRDaURXdE54R1IvS1dmcXVGaE1Qc2VKOTMxYkhrWGlqMitmaHVS?=
 =?utf-8?B?d3M3VEVJYVMwQ0tSWUJodk5wTWhYbUNFN25FbURFaStzWDlvOVFQMDdjRkVT?=
 =?utf-8?B?eUZ6T3o1TDZKcnNsT2k1RlVTR0JHRFlvWjJFTiswVDRjL2ZvVnJPVjdybmIx?=
 =?utf-8?B?dVBiUERTSHM4ckV6cnR5WnRWUWp5a3o2SWNHdTFjbjI4R1RwMGxrMW9yUUhE?=
 =?utf-8?B?WFdYZFE1ZGJvRk80VnY5Z2RneFVLa2oxOTFkUTBQemhMN1FrSEpmUlRORm1S?=
 =?utf-8?B?amhiL2FZWEpzMWVJRFdoYkQxU0tNSGRJY1JrNEg3b0tOL3JON0k2elhGb3U5?=
 =?utf-8?B?MUV3aHc2RklXMDBCZFVlTXo3d3pwdE84MXhuVW5XMjJzWTJnTi9DUmwyU0Fo?=
 =?utf-8?B?VWVzalRHTGJ4S2d4VWxYbnRoUFQ3YjcyaWdoSldJSzFWaDBKbEFXRGNveHRL?=
 =?utf-8?B?SEx6SnowM2ZzelVoZ1JNdUUzdytGdWw1d0lkSEUwUFd0M25LM01IRHA5WXlW?=
 =?utf-8?B?WEV4K3dLWEt1UUcrZE96VkV6NS9XRm9HY3FsdkdDOERhTHN0M25xZk4vK3Vi?=
 =?utf-8?B?ZGpaVjl5QnY3MnJIMlBXbUVXbTRnZWpaN0R3UE93cFZrTmR2bkR6eVdzaTBw?=
 =?utf-8?B?S1MxR3VOUlNLQUVYaGZDb3ZhL05UeW5MbkV5SVZiWGZ1NHh3YXNsRjdLOEJx?=
 =?utf-8?B?NTZFbzNuaEFZbjZudDJBM1JKYnhTUlJOcktpaktwVDNzUkUxMkRVRmtMVWw4?=
 =?utf-8?B?YW8rbzk2SVNtUUhiVmdad1dvcEFLSjJjczNGV2F6cWkySU5QSHdnWERPN0o2?=
 =?utf-8?B?WmE3Q09zaGx0dEVSN1U3R3VwTlE4NG9JendmN09aRWFySXlWcHNzTDRxdFcy?=
 =?utf-8?B?V25UNmllcHc4MHVkeDhJcFVuNDIxN0NxUVp2RE9XTWFuNkUzRlRCRzhYeUJJ?=
 =?utf-8?B?YndZTVF0ZWVIQWMxaS9NQzJycUpiejVzcHAydUNLdDZPUC93QnorOVErb0Jt?=
 =?utf-8?B?RnFTeXFQYVFYSzBRbFdkdjE1YXlhMU9qNkNMbWdHZTZ4dzRKRHR1alR5TzQz?=
 =?utf-8?B?cHJWb1NXTnlNMXJSRzdwZlA5TXhGT0VmTzkwMjcyVnJxTmk1T0phMmw2bmJH?=
 =?utf-8?B?aFc1ek1MKy8yY3ZSbTI2V3Ura25PRVRzUHJWRVJ5WkFack85Vkl1dmJJRjRs?=
 =?utf-8?B?SVN6WTdBR1FJSDlNQzJNV0grQzVCM3U1S3E1S2t5MnZHWW9OSU44bDBGUzRM?=
 =?utf-8?B?V0dLK0xnemlsQUFYR2R1dEhVVHEvNUNMYnlCVG5ZMkNyWWhxTjQvdmQwcjc1?=
 =?utf-8?B?SXFRbXEyMUo1Zmo1S0w5bSs3bGxqTWM3aTRKSGhneXZCZ0lrb0dyWmpmcVA5?=
 =?utf-8?B?Z20xM3ZhUEQ4aDNJblZwemt3NmxOTGNsUS8rRUNKRXVNanNIckFmdGpWSXF4?=
 =?utf-8?B?Mk5VTldTckwxUFNNYU5tSXJhS0R4UlAzNG5sdi9ic1RQaWRvV3NEeDZ6cEt3?=
 =?utf-8?B?ejdkRkR0bFBzQlNqVGNCdDE3OUdQRkZzRkc3V1czQTJCSituSW43c3hYQjJM?=
 =?utf-8?B?S1R2eUoraUQrREJxZWdqbnVIeWlsRVBhTXNvQlZJMk4rek5QT1JNRmNtSVY2?=
 =?utf-8?B?VWRzRlB6aEZJckxqNDB4VUxiakY5RklmSHd5NVZEY1JFeXRhaXZVWEtiK0gw?=
 =?utf-8?B?VU9uNmdESzg5QStiQnRqSGM0S1dtQ2N2NXBuSjNJMlhYTi90VnljN0xZaEhL?=
 =?utf-8?B?VUdMMXNGM25mT2FQVUxCVUJXYm90WUdEbFFTSldkRE9aYkRzQ1RlWm9XWVVY?=
 =?utf-8?B?aXlUL3lMUklDM1U3NGpnYkM3bTBqRmF4SjFTcE5NMkdQUkVHVmdyRGJOUXpl?=
 =?utf-8?B?OVg2SS9zdC9iYkRYNE42TDhyQzFWRndQdFpCb2ZFbUZ0WTNBZTIxTnBLSG96?=
 =?utf-8?Q?DlmA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54788528-c8a8-4109-0497-08dab894f02b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 03:31:45.0211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ouKKfbxFbIvhoYP0n6pKivqgpW5M77KiPuOFxlpvNb8IePtkhZboDTCQ4I3yjtyOu+HfzidIWBmEznEJdao7RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQo+IEZyb206IFlhbmp1biBaaHUgPHlhbmp1bi56aHVAbGludXguZGV2Pg0KPiBTZW50OiBUaHVy
c2RheSwgT2N0b2JlciAyNywgMjAyMiAxMToyMSBQTQ0KPiANCj4gDQo+IOWcqCAyMDIyLzEwLzI3
IDIyOjA2LCBQYXJhdiBQYW5kaXQg5YaZ6YGTOg0KPiA+PiBGcm9tOiB5YW5qdW4uemh1QGxpbnV4
LmRldiA8eWFuanVuLnpodUBsaW51eC5kZXY+DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVy
IDI3LCAyMDIyIDI6MDIgQU0NCj4gPj4gVG86IFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNv
bT47IGR1c3QubGlAbGludXguYWxpYmFiYS5jb207IFpodQ0KPiA+PiBZYW5qdW4gPHlhbmp1bi56
aHVAaW50ZWwuY29tPjsgamdnQHppZXBlLmNhOyBsZW9uQGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiA+
PiByZG1hQHZnZXIua2VybmVsLm9yZw0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDAvM10gUkRN
QSBuZXQgbmFtZXNwYWNlDQo+ID4+DQo+ID4+IE9jdG9iZXIgMjcsIDIwMjIgMTE6NDggQU0sICJQ
YXJhdiBQYW5kaXQiIDxwYXJhdkBudmlkaWEuY29tPiB3cm90ZToNCj4gPj4NCj4gPj4+PiBGcm9t
OiB5YW5qdW4uemh1QGxpbnV4LmRldiA8eWFuanVuLnpodUBsaW51eC5kZXY+DQo+ID4+Pj4gU2Vu
dDogV2VkbmVzZGF5LCBPY3RvYmVyIDI2LCAyMDIyIDExOjM5IFBNDQo+ID4+Pj4NCj4gPj4+PiBP
Y3RvYmVyIDI3LCAyMDIyIDExOjIxIEFNLCAiUGFyYXYgUGFuZGl0IiA8cGFyYXZAbnZpZGlhLmNv
bT4gd3JvdGU6DQo+ID4+Pj4NCj4gPj4+PiBGcm9tOiB5YW5qdW4uemh1QGxpbnV4LmRldiA8eWFu
anVuLnpodUBsaW51eC5kZXY+DQo+ID4+Pj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDI2LCAy
MDIyIDExOjE3IFBNDQo+ID4+Pj4NCj4gPj4+PiBPY3RvYmVyIDI3LCAyMDIyIDExOjEwIEFNLCAi
UGFyYXYgUGFuZGl0IiA8cGFyYXZAbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4+Pj4NCj4gPj4+PiBG
cm9tOiB5YW5qdW4uemh1QGxpbnV4LmRldiA8eWFuanVuLnpodUBsaW51eC5kZXY+DQo+ID4+Pj4g
U2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDI2LCAyMDIyIDExOjA4IFBNDQo+ID4+Pj4NCj4gPj4+
PiBPY3RvYmVyIDI3LCAyMDIyIDExOjAxIEFNLCAiUGFyYXYgUGFuZGl0IiA8cGFyYXZAbnZpZGlh
LmNvbT4gd3JvdGU6DQo+ID4+Pj4NCj4gPj4+PiBGcm9tOiBEdXN0IExpIDxkdXN0LmxpQGxpbnV4
LmFsaWJhYmEuY29tPg0KPiA+Pj4+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyNiwgMjAyMiAx
MDozMSBQTQ0KPiA+Pj4+DQo+ID4+Pj4gMi4gZWxzZSB3ZSBhcmUgaW4NCj4gPj4+PiBleGNsdXNp
dmUgbW9kZS4gV2hlbiB0aGUgY29ycmVzcG9uZGluZyBuZXRkZXZpY2Ugb2YgdGhlIFJvQ0Ugb3IN
Cj4gPj4+PiBpV2FycCBkZXZpY2UgaXMgbW92ZWQgZnJvbSBvbmUgbmV0IG5hbWVzcGFjZSB0byBh
bm90aGVyLCB3ZSBtb3ZlDQo+ID4+Pj4gdGhlDQo+ID4+IFJETUENCj4gPj4+PiBkZXZpY2UgaW50
byB0aGF0IG5ldCBuYW1lc3BhY2UNCj4gPj4+Pg0KPiA+Pj4+IFdoYXQgZG8geW91IHRoaW5rID8N
Cj4gPj4+Pg0KPiA+Pj4+IE5vLiBvbmUgZGV2aWNlIGlzIG5vdCBzdXBwb3NlZCB0byBtb3ZlIG90
aGVyIGRldmljZXMuDQo+ID4+Pj4gRXZlcnkgZGV2aWNlIGlzIGluZGVwZW5kZW50IHRoYXQgc2hv
dWxkIGJlIG1vdmVkIGJ5IGV4cGxpY2l0DQo+IGNvbW1hbmQuDQo+ID4+Pj4NCj4gPj4+PiBDYW4g
eW91IHNob3cgdXMgd2hlcmUgd2UgY2FuIGZpbmQgdGhpcyBydWxlICJFdmVyeSBkZXZpY2UgaXMN
Cj4gPj4+PiBpbmRlcGVuZGVudCB0aGF0IHNob3VsZCBiZSBtb3ZlZCBieSBleHBsaWNpdCBjb21t
YW5kLiI/DQo+ID4+Pj4NCj4gPj4+PiBBbHNvIGNoYW5nZXMgbGlrZSBhYm92ZSBicmVha3MgdGhl
IGV4aXN0aW5nIG9yY2hlc3RyYXRpb24sIGl0IG5vLWdvLg0KPiA+Pj4+DQo+ID4+IEFuZCBJIGRv
IG5vdCBmaW5kIHRoZSBydWxlIHRoYXQgeW91IG1lbnRpb25lZC4NCj4gPj4NCj4gPj4+IFRoZXJl
IGlzIG5vIExpbnV4IGtlcm5lbCBzdWJzeXN0ZW0gb3IgbW9kdWxlIHRvIG15IGtub3dsZWRnZSB0
aGF0DQo+ID4+PiBhdHRlbXB0IHRvIG1vdmUgbXVsdGlwbGUgZGV2aWNlcyB1c2luZyBzaW5nbGUg
Y29tbWFuZC4NCj4gPj4+IFdoZW4gdXNlciBleGVjdXRlcyBjb21tYW5kICwgdXNlciBleHBsaWNp
dGx5IGdpdmUgZGV2aWNlIG5hbWUgImZvbyIsDQo+ID4+IG9ubHkgImZvbyIgc2hvdWxkIG1vdmUu
DQo+ID4+PiBPdGhlciBsb29zZWx5IGNvdXBsZWQgZGV2aWNlIHdob3NlIG5hbWUgaXMgbm90IHNw
ZWNpZmllZCBpbiB0aGUgaXANCj4gPj4+IGNvbW1hbmQgd2hpY2ggaGFzIGEgZGlmZmVyZW50IGxp
ZmUgY3ljbGUgc2hvdWxkIG5vdCBtb3ZlIGFsb25nIHdpdGgNCj4gImZvbyIuDQo+ID4+Pg0KPiA+
Pj4gWW91IGFyZSB0cnlpbmcgdG8gZGVmaW5lIHRoZSBuZXcgcnVsZSB0aGF0IGJyZWFrcyB0aGUg
ZXhpc3RpbmcgQUJJDQo+ID4+PiBhbmQgdGhlIGlwcm91dGUyIChpcCBhbmQgcmRtYSkgY29tbWFu
ZCBzZW1hbnRpY3MuDQo+ID4+PiBJdCBpcyBpbXBsaWNpdCB0aGF0IHdoZW4gY29tbWFuZCBpcyBp
c3N1ZWQgb24gZGV2aWNlIEEsIG9wZXJhdGUgb24NCj4gPj4+IGRldmljZSBBLiBUaGlzIGlzIHBh
cnQgb2YNCj4gPj4+IGlwcm91dGUyIGZ1bmN0aW9uaW5nLg0KPiA+PiBBYm91dCBpcHJvdXRlMiwg
SSByZWFkIHRoaXMgbGluaw0KPiA+PiBodHRwczovL3dpa2kubGludXhmb3VuZGF0aW9uLm9yZy9u
ZXR3b3JraW5nL2lwcm91dGUyI2RvY3VtZW50YXRpb24NCj4gPj4NCj4gPj4gVGhlcmUgaXMgbm8g
cnVsZXMgdGhhdCB5b3UgbWVudGlvbmVkLg0KPiA+Pg0KPiA+PiBUaGlzIHJ1bGUgaXMgZGVmaW5l
ZCBleHBsaWNpdGx5IG9yIGltcGxpY2l0bHk/DQo+ID4+DQo+ID4gV2lraSBwYWdlcyBsaW5rcyBh
cmUgbm90IHRoZSBkb2N1bWVudGF0aW9uLg0KPiA+IE1hbiBwYWdlcyBvZiB0aGUgaXByb3V0ZTIg
aXMgZG9jdW1lbnRhdGlvbiBvZiBpcHJvdXRlMiBhdCBbMV0gYW5kIFsyXS4NCj4gPg0KPiA+IFsx
XSBodHRwczovL21hbjcub3JnL2xpbnV4L21hbi1wYWdlcy9tYW44L3JkbWEtc3lzdGVtLjguaHRt
bA0KPiA+IFsyXSBodHRwczovL21hbjcub3JnL2xpbnV4L21hbi1wYWdlcy9tYW44L3JkbWEtZGV2
LjguaHRtbA0KPiA+DQo+ID4gQXMgSSBleHBsYWluZWQsIHRoZSBleHBsaWNpdCBydWxlIHRoYXQg
eW91IGFyZSBsb29raW5nIGZvciB0aGF0IHNheSAid2hlbiBJDQo+IG1vZGlmeSBkZXZpY2UgZm9v
LCBpdCBjYW4gYWxzbyBtb2RpZmllcyB0aGUgZGV2aWNlIGJhciIuDQo+ID4gQmVjYXVzZSBubyBw
YXJ0IG9mIHRoZSBMaW51eCBrZXJuZWwgZG9lcyB0aGF0IHVzdWFsbHksIHVubGVzcyB0aGUgZGV2
aWNlIGlzDQo+IHJlcHJlc2VudG9yL2NvbnRyb2wgb2JqZWN0IGV0YyBvciBoYXMgcGFyZW50L2No
aWxkIHJlbGF0aW9uc2hpcC4NCj4gPiBJdCBpcyBmdW5kYW1lbnRhbCB0byBhIGNvbW1hbmQgZGVm
aW5pdGlvbiwgbm90IGEgbWF0dGVyIG9mIGV4cGxpY2l0IG9yDQo+IGltcGxpY2l0Lg0KPiANCj4g
IEZyb20gdGhlIEFCSSwgaXByb3V0ZTIgYW5kIGN1cnJlbnQgcmRtYSBjb21tYW5kIGxpbmtzLCBJ
IGNhbiBub3QgZmluZCB0aGUNCj4gcnVsZSB0aGF0IHlvdSBtZW50aW9uZWQuDQo+IA0KPiBDYW4g
eW91IHRlbGwgbWUgdGhlIGV4YWN0IGxpbmsgdGhhdCBtYWtlIHN1Y2ggZGVmaW5pdGlvbj8NCj4g
DQpJIGV4cGxhaW5lZCB5b3UgYWxyZWFkeSBhYm92ZS4gWW91IGFyZSByZXBlYXRpbmcgeW91ciB3
ZWlyZCBxdWVzdGlvbi4NCg0KQ2FuIHlvdSBzaG93IG9uZSBpcHJvdXRlMiBleGFtcGxlLCB3aGVy
ZSB5b3Ugc3BlY2lmeSBhIGNvbW1hbmQgb24gZGV2aWNlIEEsIGFuZCBrZXJuZWwgb3BlcmF0ZXMg
b24gZGV2aWNlLCBBLCBQLCBRLCBSPw0KVGhpcyBpcyB0aGUgYXR0ZW1wdCB5b3UgYXJlIHRyeWlu
ZyB0byBkbyBmb3IgdW5rbm93biByZWFzb25zLg0KDQpTbywgY2FuIHlvdSBwbGVhc2UgZXhwbGFp
biwgd2hhdCBpcyB0aGUgcHJvYmxlbSBpbiB1c2luZyBleGlzdGluZyByZG1hIGRldiBjb21tYW5k
cyB0aGF0IG1vdmUgcmRtYSBkZXZpY2UgdG8gbmV0IG5hbWVzcGFjZT8NCg0KPiA+DQo+ID4gQW5k
IGNsZWFybHkgaW4gdGhpcyBkaXNjdXNzaW9uIGZvbyBhbmQgYmFyIGFyZSBsb29zZWx5IGNvdXBs
ZWQgbmV0d29yaw0KPiBkZXZpY2VzLCBvbmUgaXMgbm90IGNvbnRyb2xsaW5nIHRoZSBvdGhlci4N
Cj4gPg0KPiA+IEFsc28sIGEgcmRtYSBkZXZpY2UgaXMgYXR0YWNoZWQgdG8gbXVsdGlwbGUgbmV0
IGRldmljZXMsIHByaW1hcnkgYW5kIG90aGVyDQo+IHVwcGVyIGRldmljZXMgc3VjaCBhcyB2bGFu
LCBtYWN2bGFuIGV0Yy4NCj4gDQo+IFRvIGEgUm9DRSBkZXZpY2UsIGhvdyB0byBhdHRhY2ggYSBy
ZG1hIGRldmljZSB0byB2bGFuLCBtYWN2bGFuPw0KPiANCj4gVG8gImEgcmRtYSBkZXZpY2UgaXMg
YXR0YWNoZWQgdG8gbXVsdGlwbGUgbmV0IGRldmljZXMsIHByaW1hcnkgYW5kIG90aGVyDQo+IHVw
cGVyIGRldmljZXMgc3VjaCBhcyB2bGFuLCBtYWN2bGFuIGV0YyIsDQo+IA0KPiBDYW4geW91IHNo
b3cgdXMgYW4gZXhhbXBsZT8gVGhlIHJkbWEgZGV2aWNlIGlzIFJvQ0UgZGV2aWNlLCBpV2FycCBv
ciBpcG9pYg0KPiBkZXZpY2U/DQpSZG1hIGRldmljZSBpcyByb2NlIGRldmljZS4NCkFkZCB2bGFu
LCBtYWN2bGFuIGRldmljZSBvbiB0b3Agb2YgdGhlIG5ldGRldmljZSBsaW5rZWQgdG8gdGhlIHJv
Y2UgZGV2aWNlIHVzaW5nIGlwcm91dGUyLg0K
