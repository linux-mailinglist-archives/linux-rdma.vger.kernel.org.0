Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31680400D55
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Sep 2021 00:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhIDWcA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Sep 2021 18:32:00 -0400
Received: from mail-mw2nam12on2049.outbound.protection.outlook.com ([40.107.244.49]:34145
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231791AbhIDWcA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 4 Sep 2021 18:32:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRB45TJBXVXfCnYv0pWumnp9Mx4ssuWVOuvrfgRCo0Cgj1euSS995YdWC7v3iZKykDa5jPY2jrDcNrGx7NDo0XPvtyoH2bwSBECJZ2AIvVqbEZ8zyXkoId6VJx69XnxNImazHRK9Nmh8yAQsXRwfwcbcN61H6hLi0XkLur7WfMebO46a0QEGB/McsI49IUMvezE/bnioKCMED0QUO49huwma4NLZ+EsUVRpkznrriR8H3o4sSudjPbZD27Xq/Zb8Sy21XJqU8Xlma+oQ8JqA8SKl53ivf18O1rZnq5+5Ohyu0KruIyuwQ6/v5zi6n+maEfDYSeiuQ0mGgZa7bbj8kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZW/lVdVDLV1eDb2nI9zKoEdAeEO2C/N9sCfWqpPdcCg=;
 b=Qpz4LtyiG15dek6V+yT3A4z7i+6jWNicFXvLu42xUD1MEplTPQCa7yDr2WfLftLf/NTndXfXAHgFEDMrZLvUhUydKG4hqNKz4EdE7rqoTqdG2IUiSd3kzDO8mbv1edv3xmAEQBfTUeaZKAOByZfkPquz6EL8pL1U3cP4nTo/IjlpbUxYGbxPzI1fhoC1Gg2lTr0g7KU1qCfMTFrXnbSNys9TrHQeQndcB8vi0N6GsvZzWXiJiJ+6jkhEkpLLEQ5QLJUuGAaWNTDGk+AdJxAB5gUtWg4qzcFWoKxoSoMVG05jtelpYVZ4ufMS8m4iU0SuiNMOXNSAmWOtzhF71SUd0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZW/lVdVDLV1eDb2nI9zKoEdAeEO2C/N9sCfWqpPdcCg=;
 b=Ne6IGmUusHeHf/qUKxg7K8Ow9XV5B8QnNM4GJof3oXbS75Tsjbk4xv3r9ZbD7xYA/cWA5HKn51Z3uLrSvFbnZ+CxCAXZqPCtHb89VPZWgNDbBEJeKkek2zpngVfxq9M6UQ09sbnM7N4f2biBTgS2DUkHh+upImE8Kdhmy3rmO28dwDc/daKXYGA6FmpGkuVlsECANHPM2zp3c7CWNTZYzhOMiZ7nfK7OrJgGEBU+UbotShOmIN8ffXZnMV00IMbS7NOvgUQG77RA14O0/8vhMys210CT+29f9MfOerO7WwxLSivFUURCVHiX0TE04g8r9XUtYSXbY/ZwvU/VaVlCyA==
Authentication-Results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Sat, 4 Sep
 2021 22:30:57 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4478.025; Sat, 4 Sep 2021
 22:30:57 +0000
Date:   Sat, 4 Sep 2021 19:30:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: blktest/rxe almost working
Message-ID: <20210904223056.GC2505917@nvidia.com>
References: <c7557529-d07d-3e35-0f03-2bbe867af4a1@gmail.com>
 <20210902233853.GB2505917@nvidia.com>
 <1610313b-e5d0-a687-a409-d1275baf7f95@gmail.com>
 <711c089d-ce66-63e8-4d80-0bd19f22607c@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <711c089d-ce66-63e8-4d80-0bd19f22607c@acm.org>
X-ClientProxiedBy: BL0PR1501CA0023.namprd15.prod.outlook.com
 (2603:10b6:207:17::36) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR1501CA0023.namprd15.prod.outlook.com (2603:10b6:207:17::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Sat, 4 Sep 2021 22:30:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mMeBc-00BNDl-1A; Sat, 04 Sep 2021 19:30:56 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce541422-f486-4e2f-3862-08d96ff3a9ff
X-MS-TrafficTypeDiagnostic: BL1PR12MB5301:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5301A50D25B36C3C678B51CDC2D09@BL1PR12MB5301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l8Mbhkg+rlY3ehTvakl2D66EPlVS+2D9y8+f3t9ADACnV6heuyVNC1lPAI7ThoxjQocITfOXUkH7ObINW8JdfJxKM/Cs5mHQZPuafgROQHDQZMCiHdksjHdBX5Njvjt1AouJTRZGEqCpiPCO/KPUpmPvtz/q+zSB8ygyc+WwDeLQiWqUDad+AYFoBwbMx65E2+xhb+GdmKVBORnvPxx44FC1t1e2LyFiRSrftJc02bM89xoN5CelQSuyJWASbo5nB40tp4T07G1ACQ1AKunsPYYhkYkB0BqlcMpihpO81SLrp2PUnyCbfg3KQTuIHk/qwQBEoRA2TXCZzdh+mpybRYOmqcDe3Rg3pP+mdIrXWPC4McPOgEYKQ6MCpXcGfkT4T0VEt6GKdq821RSKfDzAjC27tdWFdXRGF7anx4yNYXs9nYgIiJFaEtcPlzkkxnaMzD6mXADlS0jCmKo9VFy0J5Gmkgy1peqmy9bUQwfmomhq020qms/sck9DJ6dytgabq5x6GD3UWELlNjLqGFZsJqvseMJSpn8b2r3SeaenLk6z4KZT1blrdqhWNtndAmvLXIiNKeEECvPYxluvV3h/hZjvCvU9EF6jpRivxgPOVXXhUw5xJrMpihbsOTjsUwCQgcKS8mr1d1Gcq9caM8aGpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(2906002)(2616005)(33656002)(3480700007)(53546011)(54906003)(8936002)(4326008)(8676002)(66556008)(1076003)(83380400001)(9746002)(9786002)(36756003)(316002)(426003)(478600001)(6916009)(5660300002)(66476007)(26005)(66946007)(186003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p8A2ZaWn3jcIiqC9pvAo7AE71nFRmRcImX9O/fwPANwHB7evOlM/zD/l6dYg?=
 =?us-ascii?Q?evwWhVndtbP8+weHiEpwjYEBYj7lRnmyPvdEmwOXwjL/6R2OR0SAjV9nxnWH?=
 =?us-ascii?Q?qwRFYsZaQV2JA1CL87UnALfG4a6RG8KlOn92UOfMS7nk1iotpYnhhDAvSgOG?=
 =?us-ascii?Q?7c1L+hQkFlEJUhXGeUg/fogNxMi+E8egMBhcyJ3f4H8hlIow/pZbTciX5Vho?=
 =?us-ascii?Q?93O5iSV1VVyLk197N70falqNDxRCQaxPJCTRznPNbHbytiHknOlFQMue735U?=
 =?us-ascii?Q?iAC4AVEBT1P1kUsCd8kFDO0cWmn9fkD+ADioAVJvlBaWipWfti8/vzi5H9dx?=
 =?us-ascii?Q?JVmdwNAk9072c9M5JeVTwngoHEeiGsWc32IVR4EXipQpbcB1yP8P65CKEUcA?=
 =?us-ascii?Q?1VQG6Z0gR6dBOeQELPPCcBVmZqYzd7ozqwv3Q7bOzZT8bj9Ypw0FHoclmiSd?=
 =?us-ascii?Q?h33fsXtIwlid4IwmtBSFuW/4/BHDjIPd2PZuCnsapMDPmDeP3dzKDR7eEqnk?=
 =?us-ascii?Q?LvQ2CNQ3uGLrPbowwjeB8xo6hcdIV5/nTFvs3tQR28EZENM4rRoNY9X7kero?=
 =?us-ascii?Q?rLISV+zT47FkgXXWRcyYnQtNXyxuCN70eBo1vMYLgmwlCC0MM24h+SfzgZDk?=
 =?us-ascii?Q?QclNM1x0gVd/ixsGqpeyjsq38deQ5S79C95RRb3CPWg0Ws5b42Y5p0N4Z4AC?=
 =?us-ascii?Q?qaXyV+EX7db/BZ5lQLYsJKE8wIFAyNTIulj0odFXexpTGq7TgU+aQaqwkYfP?=
 =?us-ascii?Q?93ERXg/Yzmcu7pIcf3cr+cmV8ulLx29lw1Ia1cAivv9usnEIcsXNYlrDRXvW?=
 =?us-ascii?Q?z5B7Nf6cxgiSy07d4l6hYOA9Y6D8r/sPuHAmWXdJPm4RyFIN5RIIpYz0ZRo/?=
 =?us-ascii?Q?aQX0xv0PdtmmZUGpK9pqx6k8LN9wKyxvnhuLTK2iCzGWGk2AWOo6Y2p4lxc9?=
 =?us-ascii?Q?i4ZvfiycMZhZkwQR/cyggu4J8FfaAxHIAcNIa/aT9F0z9xsvaoxXjK/KQ6d2?=
 =?us-ascii?Q?J2C7+Ko9OKfB9NSU71xhVIBtTfzO+x1e3r8Nk6WZ2XyyO4hpd7TvQNe8huZj?=
 =?us-ascii?Q?ujOMyPiVV/J9YYbTJXk4z3AR6v4c0RmAiDG/4Qlii17+1BP5LD3eV6Senrq4?=
 =?us-ascii?Q?7k6J2Q/iM0XCrmfSjV3EZZ875bTOcLABy3HKQwIcF8ZN1H8ls+aMNM2ceY5h?=
 =?us-ascii?Q?52Jb8ZIhbp+WgIWZSlCQczBR0P/PIgwkVMXhwirtwRdd9awiHHO7yzqRaBV4?=
 =?us-ascii?Q?clNL6dOfAA7VY/Klzk5c4pw6f4fafFV1UYJT/8dvx6tZvN6leqQTUtn7hAje?=
 =?us-ascii?Q?tkXTcz/SIVN9wUSOaKFJzah0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce541422-f486-4e2f-3862-08d96ff3a9ff
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2021 22:30:57.0811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nw0/GH/HfAR/6GdD4S1bKhnMIXrbWUJcR4h1PBuw0bU5fRZfKbtpJW9vw8RI49/Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 03, 2021 at 04:13:22PM -0700, Bart Van Assche wrote:
> On 9/3/21 3:18 PM, Bob Pearson wrote:
> > On 9/2/21 6:38 PM, Jason Gunthorpe wrote:
> > > On Thu, Sep 02, 2021 at 04:41:15PM -0500, Bob Pearson wrote:
> > > > Now that for-next is on 5.14.0-rc6+ blktest srp/002 is very close to
> > > > working for rxe but there is still one error. After adding MW
> > > > support I added a test to local invalidate to check and see if the
> > > > l/rkey matched the key actually contained in the MR/MW when local
> > > > invalidate is called. This is failing for srp/002 with the key
> > > > portion of the rkey off by one. Looking at ib_srp.c I see code that
> > > > does in fact increment the rkey by one and also has code that posts
> > > > a local invalidate. This was never checked before and is now failing
> > > > to match. If I mask off the key portion in the test the whole test
> > > > case passes so the other problems appear to have been fixed. If the
> > > > increment and invalidate are out of sync this could result in the
> > > > error. I suspect this may be a bug in srp. Worst case I can remove
> > > > this test but I would rather not.
> > > 
> > > I didn't check the spec, but since SRP works with HW devices I wonder
> > > if invalidation is supposed to ignore the variant bits in the mkey?
> > 
> > I am a little worried. srp is pretty complex but roughly it looks like it maintains a pool of
> > MRs which it recycles. Each time it reuses the MR it increments the key portion of the rkey. Before
> > that it uses local invalidate WRs to invalidate the MRs presumably to prevent stray accesses
> > to the old version of the MR from e.g. replicated packets. It posts these WRs to a send queue but I
> > don't see where it closes the loop by waiting for a WC so there may be a race between the invalidate
> > and the subsequent map_sg call. The invalidate marks the MR as not usable so this must all happen
> > before the MR is turned on again.
> 
> Hi Bob,
> 
> If there would be any code in the SRP driver that is not compliant with the
> IBTA specification then I can fix it.
> 
> Regarding the invalidate work requests submitted by the ib_srp driver: these
> are submitted before srp_fr_pool_put() is called. A new registration request
> is submitted after srp_fr_pool_get() succeeds. There is one MR pool per RDMA
> channel and there is one QP per RDMA channel. In other words,
> (re)registration requests are submitted to the same QP as unregistration
> requests after local invalidate requests. I think the IBTA requires does not
> allow to reorder a local invalidate followed by a fast registration request.

Right

Jason
