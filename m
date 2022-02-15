Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAE04B75B6
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbiBOQsa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 11:48:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiBOQs3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 11:48:29 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BEFC12F9
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 08:48:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFM6o+xPn+aRhF3nFHUUAibptaXOhJN0UAokJjJX95bjCgHNTsAT7NHCVPJRri/C1TgKebJj3kEuTUqzA2fDYMZkqzXHfoh1+c8aovfqCUz2yYv6n48Qh6zAb2sIV5rf1BMybIXyV1NqsPEJp72ddYVEXnT+oHebCLXSOrY+Mo/IsBAoUXjzscEKtxzZtkK36A4YaVRrjrnJDhvLDNmwX3ta8xehHq0DvGOMwZYhJE38BMral/w9RBeBvCMdhbBdZdO2WU2lsEYZegGLrTETvR9SvDQ48JJwE92VwAyzOTLzernySjhX6afY9xqtQKz9j4aGFvw/Cf8++mEEXPSpUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylwspq51DPfndhf3uhf8DeNN8cVrvIjfNQvXlA3ScIw=;
 b=QRik729weXVVFvtrcGVaXFecOXJyK+X3Q5XlSRWEmbQbnG/x1eLz7rlSCFd0m4+8iwI9cDsF0rQHoBjy675NT1BL5gKrDLoWMrl0++h5uqHpAtx3X4xWneQNsdto6pwDI3o3T7R9FZHy+XadxIzrID4hTRLjqiRg1MAZNvwattde9n5irhHzKDKR/q2sPeZRvEq/BgMQSCkT5+omeqbXZoeEnNy3v4yMxVHDd3VPe/jGiwCl8tmfdVH0B+HeG/GjQ0bScezVb/eGW6SxFzAjgaBI668JglZNujsAcYHhFoslSFcapo+nHUbVisGkjE7/db8BF5/2IMy4U9jCYzPFrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylwspq51DPfndhf3uhf8DeNN8cVrvIjfNQvXlA3ScIw=;
 b=C7Dj2u4goYiflXwB0zHweHtfNEdD5M8JRNwtkoLQ8HU5EBuFe5ywWd1fzbvH/bs18s0sIoLo+BUXGgVLZ/32u+9pPs7tf5lEWBaQ5wcGFSKK54HVnF1tWHJ4zImLbG+aftJKZmNQCOPyRtMBA735FgPRReYXvcXyB3FTOO1Z9XqQra/Tk2fIDXhMv8mIqJ8C/ZydOQQUmGvDRpzPe4N0yyHQ5OwQcqI8PgQboKTpObcHl+qsDtEoUUDFcgoj2fkA1NFT0VpPIq+SrhCi5BkOpexckdTcghioAyNWT+T3lebYx+xHpL6ufQzvgw5O2Ol9EIDFLvjiD/iZsiSss5eVUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by CY4PR12MB1704.namprd12.prod.outlook.com (2603:10b6:903:11d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Tue, 15 Feb
 2022 16:48:11 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 16:48:11 +0000
Date:   Tue, 15 Feb 2022 12:48:10 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Inconsistent lock state warning for rxe_poll_cq()
Message-ID: <20220215164810.GW4160@nvidia.com>
References: <8f9fe1da-c302-0c45-8df8-2905c630daad@acm.org>
 <a300f716-718d-9cfe-a95f-870660b92434@gmail.com>
 <89e17cc9-6c90-2132-95e4-4e9ce65a9b08@acm.org>
 <04a372ee-cb82-2cbe-b303-d958af5e47f5@gmail.com>
 <95f08f0e-da4e-13fb-a594-a6d046230d76@acm.org>
 <1f781fd6-a5e6-aa73-c43d-d16771fdef3c@gmail.com>
 <20220215144159.GQ4160@nvidia.com>
 <PH7PR84MB1488ADD314438A8EDEB5F219BC349@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR84MB1488ADD314438A8EDEB5F219BC349@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
X-ClientProxiedBy: MN2PR16CA0013.namprd16.prod.outlook.com
 (2603:10b6:208:134::26) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f7d24a0-6b17-4916-c5be-08d9f0a2f3ad
X-MS-TrafficTypeDiagnostic: CY4PR12MB1704:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB170469D19CBFB5483EE19AFCC2349@CY4PR12MB1704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wIKUyLXbJ0O0krJDSTZCb08jna9zlc2AQkeE4BTUZEiE3mT15w/mKawjA5O4NGiJ92DWgICC6wj+48iCXCVaKySsUwINA8xR1zfducY+XQmMRc+9HR492FyOI917IXKB5o25uMX2XmHcaZO/rC2YjXJG+nTGUh5df/o4gf1ZH+1owliH6h6MvA7rEkQpJ/ZfPeTcMdZENmwSZYXNW2Ow2ZunyUXwzh94iWEudypPn0Bwi5oVlXec4iueDGmUDqj0WHSEFMGJgcuFXQz7fjlQca+itbSu/TIyzjykVWTyYA0jIPIOV6GX1hU9Hl+OrMx2lFd8MZ8NhRgb4PwQ8uB9DKURuVXp6hsB+xzJCWX9/Nh+193yaXJKDFp0I9ZPAA8Jv4T0CvsxPD89LhowLK7vFnTWXSSroLUP1xtZjuj2oarbuKMOswrCLFkMQNAC5u1V0COJKWuY9W13cNLrQDMIfRDukCp+W0JNMtzQfJl8kBTwhSwc83Y1u5d4BxKKWQxO0biRvSwh1VbFWq5WfJKJ6d4enpXYuZ7Ut3hYBP/GzJDpLeyRaWvmwIJjm0Fv1BPhlh2w/40pPWo6v0Bk67tvVG4fMaIQSAG/yJsUDG5zyCJSGV0KG9iY+I86k9wPlnRZ1ANwMDccQ60bEuINBl0keQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(296002)(54906003)(508600001)(36756003)(316002)(6916009)(38100700002)(6486002)(8936002)(6512007)(8676002)(86362001)(66556008)(6506007)(4326008)(66476007)(66946007)(2616005)(83380400001)(26005)(186003)(5660300002)(53546011)(2906002)(33656002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iTLB7H2DZ52VXGTSFRhXRCC3waywo7mexHcIhw0wLGu8o1Q9+tNZ59vM0Ye0?=
 =?us-ascii?Q?XudzEoAw/gF4BdfaeVYTxSQLs4q7q2iFL5pV0v+9W8z3EnuxaWAdKk8Pl73a?=
 =?us-ascii?Q?bxEoPi6shKUrhl07fCoYY1IjhsfCWw18795HX/OsiNz5ILT9VKUr3segO5XC?=
 =?us-ascii?Q?ULyJsPhtcdRKNuaegr3Aez0hTj71yADhmzrfqjiulbV5POrzpC8OHM3HtUIt?=
 =?us-ascii?Q?PotTzLICeStRIrZ79KX/+qQ2QPJVXxDUQeH54BHxkaZlpMZOvdDMaBJpKnoO?=
 =?us-ascii?Q?MHwkkSpiu8d1PdhHDnW7HgQYr7RvuHUdIsoTNYAyKSa0ISiJfSUPj9N+IDmf?=
 =?us-ascii?Q?hgE0IsE8aVXtD2chyIEgH3WQwrvw6/fXJbvu4nF3LWwxSdeVwR/MisNsi/hh?=
 =?us-ascii?Q?ePdyJr4L59jtniPg8JwAeK2QNA4r4I+xuO5ty+dJXlamOSkWDhUp9mmnJaW6?=
 =?us-ascii?Q?BLjhp55c//UmOsuSHoHbWrLe+er9TG47Rz2My6N7+ErIF7ZPJFfC9SkCTKAS?=
 =?us-ascii?Q?RkABv/fGy5R372lWCxOcZ4I0VDasNqKZ7HqMxqD+RJ0JpwAhl8TFIhewOtoA?=
 =?us-ascii?Q?3UlPWTZiX/b380jhpqwFPWHys0YMLodfeBP2fn6G0jlif3GaMY9f85sHpfOT?=
 =?us-ascii?Q?8+OBG/WfN3eKRO9YPoLe3W/y3Plsn4e3IbG+Wr6UzJuk0/lFKRHSZi2XJnSb?=
 =?us-ascii?Q?DlQamXOumgSYZsAoslGbledDVaZgj3lTOuk67RIhJREHUf5Xu9Mcgr91Y784?=
 =?us-ascii?Q?743Nk8SpziHQvQyUv2Jn1EiQxGGwFHPHD+b9KP5UQ4qbB3Zt7Sn/DiAJuddW?=
 =?us-ascii?Q?C4iLyzeqs7NeddU4JONcODnZD/0NqmV7QWddFSU1KIXNXjzf3OWXLnR34fgm?=
 =?us-ascii?Q?t6H3KqGw4x+NfoSzt+XTMnWU9gOaPf6QmJP5USZWgLhsiMbY1w93ELGkoCfT?=
 =?us-ascii?Q?MKqIfaNKg0+IGmg/fasYf4KjfZlOkppu3Dj2KKafQDOY3GISnPiZRL2wZB/p?=
 =?us-ascii?Q?/V+fb15x/7CEi3/+LuAPfdLqBb6u1YVDAy95j+0x2wkZyBIIl2sJBemeYi3Z?=
 =?us-ascii?Q?jTlwElWGuk3ZEuR5VHbuMNfxbcmYE2n06aWHX0I0ZMgTuI0g+q1Tn0zaL2Vj?=
 =?us-ascii?Q?tkmyRbcs1H2B1DTQQhjIvCtzvwm0cLZZIfKe4pYTRp5B3/Xxfmwv2fiyiNTE?=
 =?us-ascii?Q?14aBbFM3hMBMxM/JogAPLQ1yEtOWzXBzQ2E1YXvhf7v771mztMjBHjMCxity?=
 =?us-ascii?Q?aab2cCsA82DcUGweuWZcCvPJfDBQ+L93ewUOAsJ0100kCipo/wbsnLX9sueX?=
 =?us-ascii?Q?jrHckY+tWgfn2aVqiQpTFg/J6m6iZPlL6NZb+10DwQ5K/JNiO8yiG9IzRN9a?=
 =?us-ascii?Q?kSi0Txafp9Mg+pHMgWOWIpd6COCC0m9GP7lY/oNedyJl2SSJ4NAgYzj0G2Wk?=
 =?us-ascii?Q?8myTFaP7foz1yhsiygo+uMHwhL9Er5xMUkuzn7iF2w+p1Lwb4+m64lvQMBMP?=
 =?us-ascii?Q?AIYF21ZIBbFCDr7h1gFYsl7znd326Ll64mXBwddQ1lX7aCPZL8OEL6kNoN0p?=
 =?us-ascii?Q?rujgkVjnRBiuCiftWKY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7d24a0-6b17-4916-c5be-08d9f0a2f3ad
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 16:48:11.4518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/Fj78IbLkziM0l6T6SkSQhqC+eO96x0IC75Nk96LffpcFv3X58s4j5715HH7zte
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1704
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 15, 2022 at 04:45:01PM +0000, Pearson, Robert B wrote:
> 
> 
> From: Jason Gunthorpe <jgg@nvidia.com> 
> Sent: Tuesday, February 15, 2022 8:42 AM
> To: Bob Pearson <rpearsonhpe@gmail.com>
> Cc: Bart Van Assche <bvanassche@acm.org>; Guoqing Jiang <guoqing.jiang@linux.dev>; linux-rdma@vger.kernel.org
> Subject: Re: Inconsistent lock state warning for rxe_poll_cq()
> 
> On Mon, Feb 14, 2022 at 11:43:40PM -0600, Bob Pearson wrote:
> 
> >> in the write_unlock_bh() call. This appears to complain if hardirqs 
> >> are not enabled on the current cpu. This only happens if 
> >> CONFIG_PROVE_LOCKING=y.
> 
> > The trace shows this context is called within a irq disabled spinlock region. Ie this is trying to do
> 
> >   spinlock_irqsave()
> >   write_lock_bh()
> >   write_unlock_bh()
> >   spinunlock_irqrestore()
> 
> > Which is illegal locking.
> 
> > Jason
> 
> Yes. I figured that. But I don't know why, or why
> 
> spin_lock_irqsave(lock_a)
> spin_lock_irqsave(lock_b)
> spin_unlock_irqrestore(lock_b)
> spin_unlock_irqrestore(lock_a)
> 
> Is clearly better which has been suggested as a fix.

Right

> Apparently someone above me is taking an irqsave lock and then
> calling

Yes, the CM code

> Down to rxe_create_ah().

Yep

> Calling the verbs APIs while holding a spinlock seems likely to
> cause problems.

Indeed, I hate it, but it is hard to fix

> This looks to be in response to receiving a MAD so possibly is a
> call to ibv_create_ah_from_wc().

Yes something like that

Jason
