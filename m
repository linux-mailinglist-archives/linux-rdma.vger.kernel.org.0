Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0BC7A843E
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 15:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbjITN5B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 09:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbjITNzz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 09:55:55 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADDC13E
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 06:55:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTPT3kXC8l7h1EwuWQlE9NruMu8WgY1wMmXGeslbJSeyDj8uspKgoP5IuIN+r7FY84fv+kpquQwym3LeJr9FIhbbzv+l1etfbA4U7pvf/EckRsWZ5xi+DDX+DTje1zLhXGfrNupBARdXWrEBQlz5ZfZ4VEVzibc5KXVG2JP8fmRcm0n7L9ry3uhEgWvBCOlJJQJXDGEiuWsJJXyNJvr+JO84jVugf0X9ULcMMMFeLFhuPytqDReBYxX5+RHS5QV4E8CR6FXTbSJvb0IEy34aVqOyciKg1rQr2OBTqdL7USYFY2S6PWpgOLjjlEcG75y9MIA2Yzj++liG3/zvvK+MLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8f8oqm1wcR5J9Y3ELF1/hLHxfGOMeyOpEsmO02c4hDM=;
 b=OpJdg1zF91/k+x8ajOnT1GQ4Y0a5cs5mDc9NTpbFZcJb1yUJqaQHTnzNiKdvw/Dw2+hsRkIUrVfNzPMi4BqG90mb/i1qKgmJzYyWgjImpvkX4RJsjaeQN8ob4UPmW/kCpU/le2Ql66YgXoug9M7O1DnHDJxHAW3q8ZrLce/v0Dta26N/+0kVoZauiURZOyurtgAHUJlDehDuTi8pracQ9MKQiu1SoQoiV9w68eKgNmbdN+vcjoI7uSQ34aJJRLj0cp2k5JCm5DjoYWw4+sfOfbp3LY7HO4qX/eIGJGdSE6YCytmDIz4Ounagu9OAHwu52rUL5kTSFnAgNHMCcsjK3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8f8oqm1wcR5J9Y3ELF1/hLHxfGOMeyOpEsmO02c4hDM=;
 b=FeeIkeRDpbMGMxEuk0EuAYmUZKSSxslr1jZUqgBB57HHifHAHGFIW59L5gZkiRrygd5WkxGo+0GITgjvjLMp0uFsv4uem6fK/D+pox5h7QNtk3tKzeEcCSG/NC8sQlO7kP50muh2qyBq/HvI0g/3+MfZ80l1M/cGoWiDAoPZ1hOTlroOI5n2Wm9wf4Pd90ttbzKKNHZCfCwJgqyb67/35NTbLFR3o2G82XvUhZJQ/6d4sQ1dcf+lR9nCx/MMZBor3L5QMOKF6jI+waq6NLE71rw25YIpxfLa2B5FPDB1lJO/hrF34HrhsCvcgq9GJgxIvyTisjsoBLKJxNOqLCl9iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Wed, 20 Sep
 2023 13:55:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 13:55:44 +0000
Date:   Wed, 20 Sep 2023 10:55:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Vitaly Mayatskikh <vitaly@enfabrica.net>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        linux-rdma@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Roland Dreier <roland@enfabrica.net>
Subject: Re: [PATCH] RDMA/core: use rdma_cap_iw_cm() in rdma_resolve_route()
Message-ID: <20230920135541.GA13733@nvidia.com>
References: <20230918142700.12745-1-vitaly@enfabrica.net>
 <20230919072136.GB4494@unreal>
 <CAF0Wxh=YhKCLbOLZ+-b+_rmzRoWQtqoBGn6Bo9X3zR308Vm1zA@mail.gmail.com>
 <CAF0Wxhkxa1Lk76nnkTQbNL6_v_4amczVd=wodPt00iOU2WB6+w@mail.gmail.com>
 <20230920054452.GH4494@unreal>
 <20230920125507.GU13733@nvidia.com>
 <CAF0WxhkuN0J3K5tUw0rb3-v=zKPKTh5YcCGSciaBXx9yfN-GEw@mail.gmail.com>
 <20230920131032.GY13733@nvidia.com>
 <CAF0WxhnXDfXE94O7etK8edWGiA+b4D792sNzz8b7w7H7D_=kvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF0WxhnXDfXE94O7etK8edWGiA+b4D792sNzz8b7w7H7D_=kvQ@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0105.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ff95cf-194f-4eb6-a18c-08dbb9e14903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Vd24OcMH2W+4rUnioGcmd/R4AeGq9DWRQC0+EHfF7zCYpj9vnTB54mwRf/Vi5ZNLU4QO5GOXtgKI59X5Kygnv2Ehry6BswA0Gltb8pUnlQ9J+juVfO7qp3F24wcsvmzN5dSHDb3mfGd8sbqXGzDmXC8OMTJUegxaaA/3Te10L0zfLNlVoAirjIZui74br8d83mg9U6GPU05WXVlRNA8HxmidIIeh7VQyoJYmDnG1Gih4SR7b74HHmvjHBCWjQKcIEPJ0JkCXJU6LbRqbd8Z7cvUXiy5OcBh38IcqNxNl96l6ERrpNKDAx2K8L++CLhO6HjrDHp+/bNnGyzj4Hxk4vIr+OsTBrHk6oxPcECTCfG4JqKuASlV9n/pdkNJKcPgmoRItMmKpWoPOYaMr8/kX4yRZOxdKWD3n8NiJPx4grqIi++4GdcIQlqeX3/A8swSamzBHIpxwnRMv31sD+C/l9gJeX1oFNkKojs82Jd5ZsNJ2A7HNbT8OeguAF9dUTBizMvQZbiTsXIDq8vICB++La2KjAvOZlqzGh20EAgOgVVnQA2M91HDMwkFBAMZ6vTr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(376002)(346002)(186009)(1800799009)(451199024)(26005)(8936002)(8676002)(2616005)(4326008)(1076003)(33656002)(2906002)(36756003)(4744005)(5660300002)(86362001)(6506007)(53546011)(6486002)(6666004)(6916009)(6512007)(478600001)(66946007)(38100700002)(41300700001)(66476007)(316002)(66556008)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWVva2NsemFVblo1aEk1TWJUczBEaXorTG9MZ3lBcWp1bGRtMGRmODdsMjJ3?=
 =?utf-8?B?QUpCdzFsVVJveHBHRWxVemQ2Y2FiTktxV2EvRUhNcTBuS0plNGt2cXFGOTA4?=
 =?utf-8?B?UERzV3RLcEp1RjhnajRuR3Z0QmJhR0NmSXV6eURSazhtdHFSenhGSkZoZkYy?=
 =?utf-8?B?NmdmMDlkN3U1WkNDTHR0dHJKZHAxQXcxL3lOTjYrcTF0cUJTYXVueWVlTllO?=
 =?utf-8?B?MGZwb2oxaVNMcFgxSFhucEx5djBBcHhxNmlOb29McGxpRUc5cnpTdTlQQjJQ?=
 =?utf-8?B?N2FuOFN6aGVjUEhONTNyTmwxSE9UcFBZOStPRWpiYWtoWTU5b2NlcG5RNzBO?=
 =?utf-8?B?eVVROFlNanJmeFNFV3FBWjhSY1hMUmpiTDZhNnNsY0p3SG9ZZU1GdCthSGU3?=
 =?utf-8?B?djZ5OFRGd2FMaXAxaWQraDVCcjM5UGlBZW0zMmdFT0g2WmFOUUdFbWJKekFL?=
 =?utf-8?B?OUtuQytoYmF4UW9Za0xUL0FHbC9CZUkwS09HbDJzSG1MVHQ5c1NNU1AwVWww?=
 =?utf-8?B?VEpmV1pzOHVGTW9Vakk0ZzNNZElGSjNQQkF0VU1rbjlwNDg2b0w0ZUE3eE1B?=
 =?utf-8?B?UlM3L1VXTVQwcklkL2Z0RDdoZUo2RXp2ZzlnYXA3RTdack9ZWi9ETEFZaUFu?=
 =?utf-8?B?M0dPejVwcHBTOG5FajVQUmhiN1dHZ1RndjluU3Nmam5GeHM1dlNQQ3pDQzl3?=
 =?utf-8?B?bmZwbmFmamZCWGJRZy95YS84ZC93VlZ0RE1Ja0V2SGhZcFdYZ2w0bzM3a0NX?=
 =?utf-8?B?aHJqMlFFT0NCcW1nbGo5d2ZiTi8xakZCS0MyQlMxeElIRlJjTXE2OG1TSUNl?=
 =?utf-8?B?SENPaS9hY2Vsb0JUY0cxUldXSHpsRkhOdWVaNWpsaHM0bVBuK1V4Y3d2ZGVx?=
 =?utf-8?B?SDRZZjA1SHZ3ektZaDR4U0FhV1llczdNUzZ4QktiSEZiWkJJWWpIZkhtWWFT?=
 =?utf-8?B?dTUwRE1QY2NyRWZyNVR2NjRkZkJMQTQxMjJoMWdCY3UzeGNJYVJoemErMWZ4?=
 =?utf-8?B?aCtGemFheVJnekExS2Q4aFR1NU1LL2orS2grMWdEM2IveG5sUmVxYW81aGFI?=
 =?utf-8?B?d1Vha2ZXYXZZQVh0czZKVXJHblQxbzZ1VzZhRHRkeFJvdmVUdEJEK3FZZTZ2?=
 =?utf-8?B?K0VJc3U0a1BuL0tLcmNmcnpQTmNZNDdlTGcwVktTVytLcmUyTGNOckFkUWxi?=
 =?utf-8?B?NDcrdXFraklpTVAremZNeFpkMkVTeVg5ejJJMjQrZXVGeUdRUFVSMEhISTI5?=
 =?utf-8?B?SCtZWXc1c2NMd2oySnlrTGk2NHU4L0cwL0FQK2pMU1FiUmZlb0M3cTY5SDhQ?=
 =?utf-8?B?eE10czFOK1A1eXdrWWZITkU3TE00cUFkTmFSajR1SWExakltRVkveG11ZG1k?=
 =?utf-8?B?ZGxOQU8yQWRBZXNBakNMWmhHYTNzb1kyRlY4K2szMEw3dmRIL0F3OUZnWllW?=
 =?utf-8?B?V2tjTk41Q2VVOWdCc2JvZE9IekhOM3IyNUVHREx6WGVVTVRhQm5aSis1VnhS?=
 =?utf-8?B?YWs2YklIK0trN09BcDg3YWYzeThiSzdsdnJWUmFiSWgwMEwxUEdONitwelN1?=
 =?utf-8?B?UXgvS1lWN0tlWXJCK0lJRFZjQmlQMG5PWC9oYU9CUGxvVVc2cEhqckFMcUg4?=
 =?utf-8?B?Z3A5dFJBYk56bjdEaTJjZ3ppcWxHNzRIWEpKTFc2Zlk5NnlrTFdJdEkrODY5?=
 =?utf-8?B?bk0wNi82WXpCRzFFMXE1YU02cDJYV3JNWCsrL0tMcTl1RnoyaWN2YkRJT1Jh?=
 =?utf-8?B?a0J0N3cwaTFGdC9CRUlIdEVBUTNXdytCb0dsNzBwQndoWDR2MjdSNFg5RklR?=
 =?utf-8?B?NEwyTEZobEZlMzZPOTVqV2VXcExlNitnME5CdjFnSkhhVW52bUgySjVTWmdw?=
 =?utf-8?B?OHdOMzI3VzNNLzg1L29WazkyT0FNd1UyajR1UmlYK2xnNXgweEFNMkZqNEpH?=
 =?utf-8?B?Q1hOc1I0TG5qa3hreFRXQ2poQXp3dmpZRjlNZ1BFZ3NVSEtYeEx5dm9xNEtx?=
 =?utf-8?B?S3V5K1VFMzFLUzBtTW10R2FNcFRLbGJtSDZwa0YzMklCdys2L0xFVGNqMSt4?=
 =?utf-8?B?SlNzNWNEdkRtODZrd0hJSmYvM2J1aUwvNm9hV1hQVXMrLzY0VTZGamg1bDJ6?=
 =?utf-8?Q?zUJKh8zANuW5ky6qGjJT4gDjE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ff95cf-194f-4eb6-a18c-08dbb9e14903
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 13:55:44.8409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HfvhK67cpoThr3dS1DKpanXh3dZyMP823i9ejZXjlbJqA5gvsmm+x2TXZBEQzMpN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 20, 2023 at 09:53:00AM -0400, Vitaly Mayatskikh wrote:
> On Wed, Sep 20, 2023 at 9:10 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > But is it iWarp?
> >
> > I'm not keen on seeing people abuse iwarp stuff for some non-standards
> > based thing. iwarp is already in a disused state, there isn't enough
> > community energy there to police something non-standards based.
> 
> No, it is IP-based, but not iWarp. Using CM implementation for
> IP-network (IW_CM) was a logical decision. In fact, IW_CM can be
> rebranded as IP_CM as it is not tightly coupled with iWarp per se and
> can serve any IP-based protocols.

And what happens if one of your non-standard nodes points its IWCM at
an IP that is actually running iWarp?

Jason
