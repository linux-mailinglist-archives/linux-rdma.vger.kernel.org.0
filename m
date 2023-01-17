Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0145A66E7D8
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 21:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjAQUkE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Jan 2023 15:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbjAQUfi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Jan 2023 15:35:38 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2097.outbound.protection.outlook.com [40.107.93.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0AC83857
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 11:19:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZpxI8sPbBV3KOQMSEx3b8lhk2RhCFVOfvQS9k3tVYJb6vX4XbbIQwkARs1MjRWKCmA+5n53MT9XLoH8++xShuuQWpDAgSueb71xMxY+vNMBbihsXQiBbT5jCo8TGnJMXTkmx/zydXSBXRBfUQ/rN3CqQf96lkbtJ69GYsEEvT3HfuoJFP1P7Z4ZzdAo4AaearvfrClmcQUK293Wl63atwdnJzhz9djxJ+7SzL4S6trpuD+D3o4Tb+uPXvg/DCSQ1FfmjQeKM+sV7vnad3TR0YZZooMasXUhGYsSzcBB0ZHfwWILsGlWjGNPh6Ayv9a32HttV93SliyeKye02xGidg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QS7/oS1p5QFPGghtbO6V0B80sOfCRFifegA63BRMBqY=;
 b=C6BG3PYi65B4EMfFOjb+wxmeAuRViIffZSVlsH8sZhadGdxt3VGcg0R46WOa8JtNwayJIRt5DKejq+Z8HRNX416Uy1FzEkn23GJgy6piZmgi5CP2UNnlxftmEbpoFFymhtXD0Y5WsYNxUq6RpXGho2bcxTVWzYS82+FFPBaHEh/sP9iESJDQJXhEgjA4DZvlD93eqC1hhRjZok8SpbgEZGGKayRbpQWAXnPC7YQw2nz7DO1KmhZYTXUaWapDut8Md1sOoF1I4jlAzYQQB6oedugLylUgLjhwnbaL1xe0PwssLcLps0GZorzrSvKcQ049jThHaE1kqFs8r+W2/7ja1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QS7/oS1p5QFPGghtbO6V0B80sOfCRFifegA63BRMBqY=;
 b=fT5FGhX5Z9NWubXptqCFkvZs1cgVqx5hTVDcWIhhHtpiNT4Lk/bcTIESTwV46hl14MeP94nNMeDs3cpchq3vkNTZvb0N4cRncIFnzYUwL9JevJE67PvnnMHfG/bJUTmIhbK/sNlaTiduqmIX/QEvyUt2/S20BZnT/uAQuqVoEA1jNsUIji8XdpXDAi6svU240mWKV98ivaFZED+pyHsiCxu5v/kkypRi4fjA6tGqNKgCbjvGlsczzQnPbQpeczL0Ys+Xg1iRvXJzULnYEEQPTYEpPYDk1WyyReK47ZJBOBOkqW1vIXyrHWxWnmIQUo10sKiDjpx6fagvXrQ1BWwc1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4131.prod.exchangelabs.com (2603:10b6:208:42::20) by
 MWHPR01MB2622.prod.exchangelabs.com (2603:10b6:300:fe::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Tue, 17 Jan 2023 19:19:17 +0000
Received: from BL0PR01MB4131.prod.exchangelabs.com
 ([fe80::932e:4a9f:425c:11d3]) by BL0PR01MB4131.prod.exchangelabs.com
 ([fe80::932e:4a9f:425c:11d3%7]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 19:19:17 +0000
Message-ID: <a4027240-b711-bd11-1f42-c16d53104f6e@cornelisnetworks.com>
Date:   Tue, 17 Jan 2023 13:19:14 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH for-rc 6/6] IB/hfi1: Remove user expected buffer
 invalidate race
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     leonro@nvidia.com, linux-rdma@vger.kernel.org
References: <167328512911.1472310.3529280633243532911.stgit@awfm-02.cornelisnetworks.com>
 <167328549178.1472310.9867497376936699488.stgit@awfm-02.cornelisnetworks.com>
 <Y8VwHYPYlV459T1j@nvidia.com>
Content-Language: en-US
From:   Dean Luick <dean.luick@cornelisnetworks.com>
In-Reply-To: <Y8VwHYPYlV459T1j@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:610:20::36) To BL0PR01MB4131.prod.exchangelabs.com
 (2603:10b6:208:42::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4131:EE_|MWHPR01MB2622:EE_
X-MS-Office365-Filtering-Correlation-Id: 8502c437-b627-464a-2300-08daf8bfba19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uoNVPtSysx7nFkHAkif0tkWnQdzkPOCfbc9QqeEJ1yvKe3Ackyewla9Y9z0jfX+4oS62rCVtjsspveuVOmp3DVhIGF30pLX66gj/HtoOOcogEp+CD0PKP/wsIaa4znfsReuaVML7vHMUrYV8Offc9BX6XNUor4+9AR0csqwGQOm2py1Qekpzc+Mzo8fwa8GH4JzjpMuJlOUdZY5LtJ1LGpp9GgN9v4lJU32PFUZq+fEU9XctHFSk3xGTHhsTVnunTOXZMlK/GOEnEALC8BoLbS33JSYEvqb8QDYTVi3WbpQhl7OYGSqN6Ux21q4/Ll2mjaRdmB/BVHKmhJRyXUKrgQh5tnbjW5Pl0d5+U4XTnGmpgwXHz+9VtOxqy7eFMM9Qh6TmRX5wc33f+Gk/2LDq+p0oh88VTmSmgGI4eIGynlIUEFVu8fEi9l9Hzu05xI+MPhnEqd/K8TkenIe/lym9FmwtHZXlSnpV7sdcI2HCH0+Ct0HFnBOTqNmaWAk7USr3tl5YDwHSaa9e7YB4Y4WfOu4eIswU2+bUiAUvG7uQOlVvtiaqxEf3C8qfP0lH28DNPwNhrYs6OBKWracSBkXZtopXxl6y5qXemj7DXwf5Tioq/M/bbEJWB7hWIePPTjgqhezBGWDSrD+94ZQ1N1N1KP4GWKiYR+EzRvprPE66HpzhJS7YqOL/lGan1ZZZFS+1NO8k4aDMZumW/bh3Mx89jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4131.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(376002)(39840400004)(451199015)(31696002)(36756003)(86362001)(53546011)(6512007)(26005)(66556008)(8676002)(4326008)(186003)(66476007)(6506007)(41300700001)(66946007)(2616005)(478600001)(6636002)(4744005)(110136005)(6486002)(316002)(44832011)(2906002)(6666004)(38100700002)(5660300002)(8936002)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QktDdlIyelVqQTdjZHJIa29VZlo4a0NLUHRsdk5xc0g1U2MxbVlDZG5ueTcw?=
 =?utf-8?B?SE5tMURycFVUbTltK2g0a1EvTEVLbENXVFFpWHdSOFB3MGg5VnJPb1FVZlpP?=
 =?utf-8?B?dWlGVm5ZN2FUODc4VDZ6NllMVlgrMjY5RkU1QU52cVN1YnV4ZGxoc0RQUUNi?=
 =?utf-8?B?TXp4VWIzTk9hUTdLUXV5NDRKZy9sUGphOVZFamd3aVN5aXFoRFd1TEZoM1hS?=
 =?utf-8?B?WmVZaEpDQ0hJNFBGT0ZNN0Y2SWhrSVFqMnVBVlE3RGlMeTFKYzhTRTdkSjZX?=
 =?utf-8?B?MnlVR0JSUkFkRHR4aHIvL0RWblBLSjhxVHlxd2p0TUgwZE5Id29UQ0V2b0g0?=
 =?utf-8?B?Q1cvNk94dHU4OHpzbnc1Q20xb1N4dVp3K2hNc201REJYZ0cvSml0TUtyWVRV?=
 =?utf-8?B?OVNaV0QrVjM0TVpaQ3piSFpNK0FmdTRFUTV1NENESU1QV0tyMndSYnRlVzZ2?=
 =?utf-8?B?dStSZ0UycHlZTjZLTkpzZDdKSUZvVWIyU3FmQjFoMklGZWZ6L3d2L045eVJi?=
 =?utf-8?B?QXRDV3FZUUhRTUhzQUxlQW1aRVo5Z2VvTFpwaGNDZGE1aklQbDFYMU1mZTV4?=
 =?utf-8?B?bHJVc3BRU0RyTFZqU0UzM1pYTE1kL1d3LzNuWUFmU0JHR0pjV25oUUxxTHBn?=
 =?utf-8?B?bzU0QVJRaS8ydGM0RkVwVEVmVU52NUo4a0hIMkFPcENIaTdZV2ZzeVUrUnpt?=
 =?utf-8?B?TTZhbmxxWEJGN2ZlUnBrbVZzU29oMzdiLzdjSEpMWWVGbkFHOVFZdzhjWmZX?=
 =?utf-8?B?STJDNmhxN1F3NFJKaW5LbTNzZVh2QmJ1SXF5TXM2c09FZU1TL3FUblNZLzJn?=
 =?utf-8?B?L2U4UHNKbEtMS0FIbVlWWUpYL3BIdG9KSC9nSVFTRitKSXpXVktXaWMvZlU4?=
 =?utf-8?B?YzY2SkRoZTVpVFZiOUdlcCtKVnBZMVBoMkx5eEsxRnlnTkRnall0U3hCbnZt?=
 =?utf-8?B?NkViVXc5THdBck5CQlozK2VWK0hxdnNhajRrVXF5TjFQN0MvOGVKVDlFSHlo?=
 =?utf-8?B?TGJpaUo1ODdsdkRUdkdReVJ6Y01mUGo1MEpoQ0dQVklHd1BGNUw0U280K3ll?=
 =?utf-8?B?bUFGV0xVNk8rUERPcjc0UzVxcFhqUUpmMm85ckYvU1VBdXJvRk94d1dIYjNm?=
 =?utf-8?B?R2JPQ040OHFHWE9YZUhodHJDL3dOQ2gxYlJuamZ0TGlwYlQrbTFBNUZlLzFK?=
 =?utf-8?B?SVlFQklUUis4OFhEbnBEbHd1bGM4MERpYkU1VTA2L25HZVhPdzEydldVM0Nh?=
 =?utf-8?B?TU9tWUd0QUVNSUY3MThuUHNaeENFS3c5bVVyc1FWSVVaSVBUdlRxcTJlUlNy?=
 =?utf-8?B?ZjlIZWFySEEyR1NlLytVeE5mRDI3bnE3elFpYnpRbUtGQ0dwL0luOGJwSi90?=
 =?utf-8?B?VXZQMWlRODlxcEdSN2xkRFptVW1zb2tEQXEycDd6KzFKSnpndDhtb0psRGEr?=
 =?utf-8?B?b3BiQ01WYUpSOHIvUjQ1TlBLOUdWQjdJeVNYblZscTl4blFZcnRFRzZINDRV?=
 =?utf-8?B?clNyYmY0aGhVa1dnRDVPS05lM0NZWk8yNU5kSDIwbkYwV2JhdE1aWHUyWDg3?=
 =?utf-8?B?bTBRVGdHMS9ZVXB6RytERlZPZWJzRSt3a2hhTzBMd3RmQ3VlVGZSMVFHY0lO?=
 =?utf-8?B?ODNuUlRxYjdYQjEvZndSMXJGS3hXMWthUGFpSzlqeUkzclNwN2dPaXFEMFBr?=
 =?utf-8?B?bUhINDQxL1p3Z2tBM3BqRkZ5NWdWUVMrc3h6VlpwWlEzbUt5bUNHMjF3d3VX?=
 =?utf-8?B?Wi9vOEVONmpvOTBWTW9GWmcrWmp1SThxdFZKT3EvNXdoVnR1VENZaFhWeDll?=
 =?utf-8?B?VENmbnFhK0ZEeFUrekkxK1M1V1B6bVlJcDhDVksyMmx5N3V4VTc0UXdCU1F5?=
 =?utf-8?B?bnZuckNPbDJyaUZhc016SFVxVy9EaGl2c20vQVduYTRTcGR6R3IzMkpPT0dH?=
 =?utf-8?B?MjBCajJWZnNCRENQMTdNWnZDYU1MSWN4bUNYWHNlS1FtellOdnZnS3pJNjZo?=
 =?utf-8?B?YlJ5OU5CTVMxRXVEZFg3VTlkQWNsakFCNEVQUE80b0UzVzRiRXBrVVVzR0Rp?=
 =?utf-8?B?N2ZWSi84VFJQMWZabllzUlFFVzlWby9ack1jTFowTFVnRVNEdXljNTdJMjJE?=
 =?utf-8?B?ZG16U2xaWUNUdTRkamFtZzRkMTBZYjN2Njhqd3ZOWEtRUll2Z0RpU1dtcXll?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8502c437-b627-464a-2300-08daf8bfba19
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4131.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 19:19:17.2091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1NP2s8khP0BzjuPoMBWu7XEQ4Ep/gmq6hAnMf/9OL7Q/djFiAY7shpZsuizf1HIPvsQb2nsIG0y8i6rQ29St8Sl+XbxCz0TC2wIjmVbTXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB2622
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/16/2023 9:41 AM, Jason Gunthorpe wrote:
> On Mon, Jan 09, 2023 at 12:31:31PM -0500, Dennis Dalessandro wrote:
>
>> +    if (fd->use_mn) {
>> +            ret =3D mmu_interval_notifier_insert(
>> +                    &tidbuf->notifier, current->mm,
>> +                    tidbuf->vaddr, tidbuf->npages * PAGE_SIZE,
>> +                    &tid_cover_ops);
>
> This is still not the right way to use these notifiers, you should be
> removing the calls to mmu_notifier_register()

I am confused by your comment.  This is the user expected receive code.  Th=
ere are no calls to mmu_notifier_register() here.  You removed those calls =
when you added the FIXME.  The Send DMA side still has calls to mmu_notifie=
r_register().  This series is all about user expected receive.

-Dean

>
> Jason

External recipient
