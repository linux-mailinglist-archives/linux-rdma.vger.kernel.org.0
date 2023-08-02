Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4289D76D0B6
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Aug 2023 16:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjHBO6H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Aug 2023 10:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbjHBO6D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Aug 2023 10:58:03 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BDBE70
        for <linux-rdma@vger.kernel.org>; Wed,  2 Aug 2023 07:58:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHJPQ/6Ow5Jo2f4hsgbhXbDWFDEKLcn5zL1YVYnhDLuYW7x+tVfZ04ja72k/UTS5WIg8LgZ1uLuPgb9jwlb+l3HDUgkxpBwPAFgBEcDNq1nnsBQCcc7TuQEn+N32IbsvYj71XbXB5sobnwlgBSTiDBPCosS4mZLQoELo3uZlQb5zHfZgchHvGnnIaVZqMMfg+dWQVU4ynabFLWAfrJNs25id/nt8AQddOrWwIG9/U3r8n+PrYY46Z8Qm/V3ry9THMSdeSWgkAg3N8zsNXOKD4JT29BcJKuQKNKDzvbt1W4r9EfSrZJ0u/jCcPB02isM9R8rs8rA0tzmLXPEquSorIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auDgnZFr+VDUXd5PRop285rA9G7eUf8sP8dA6deO6FU=;
 b=JLO944XkzoXaXnqh8ZFLCq0HQLRyn+ueC/DdOk3ZBBMrY3T2Zja8byDUyOb7REw7rKejznOcQgpS5gLy4Vp19hztya3wmUtlUJftvH+pklTL/kV5fCd9cQ8QE/HVCeQBmosZjbgMUfg2G3nGSoqwOyTX+6Q+zaob7XlCaByYp8ue9dr2qxOwG9wKp/TfLgKVcUPWidmltC8t5k9QtAuviaUyqqjX4/ef4WrERZ1eeDXYkNdRF6vg3j+MRV82v/CXrqpmS2OpZkcjJG82lIlWBkbl4YxYpcdoK5JORigUPc4+RybZiGNZ08/OskvM0gQRZs2zkZ47fEB3aS2GR9dT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auDgnZFr+VDUXd5PRop285rA9G7eUf8sP8dA6deO6FU=;
 b=O+RXJoSvL3F1thGprT3oE/1mXSMGUcECzDIUfG7KJUZjRUGfDhZaFybvwmB8v4RlyX7sGuSz+AvubSGc8LR0kCBhOYjbRPZn9EfLHZqDDL8OueSBwGKL0ZyQ875nvtMgNHOEnX1OPOlHU81YP638LzNQizxkHcd147d51vBOpQpY0cxMp8rwD2rUCTShzE7mTLWAKL3MvUHQ9BEvQAebBQnKKOhqUcxqr3m/6QJ1dTSuRkgWsf9f5kBL75Ge8h6jPWsWHCEKP6cMD4fTugDWJ3zr2OivsIifR9kzxfgiuP+a1A8Se+QYSQcSviUZHcU5exzOYq5ODrONclSdFRGCJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB8062.namprd12.prod.outlook.com (2603:10b6:a03:4c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 14:57:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 14:57:58 +0000
Date:   Wed, 2 Aug 2023 11:57:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 9/9] RDMA/rxe: Protect pending send packets
Message-ID: <ZMpu86c4HCoFwIUA@nvidia.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-10-rpearsonhpe@gmail.com>
 <ZMf6xkpicBpXr/B9@nvidia.com>
 <1ee51a2d-3015-3204-33e3-cfcfaac0d80e@gmail.com>
 <ZMf+ILKLjW+09Hhm@nvidia.com>
 <3156272e-91e9-8253-e09d-8a93af3f3258@gmail.com>
 <ZMmNsnJeyGcTeNNp@nvidia.com>
 <dad6082d-24f8-ccc7-0714-e89141159eac@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dad6082d-24f8-ccc7-0714-e89141159eac@gmail.com>
X-ClientProxiedBy: BYAPR08CA0063.namprd08.prod.outlook.com
 (2603:10b6:a03:117::40) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: be418fed-82d7-46ac-a680-08db9368dbfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FdFxiK/90CaUqS62Wg2WvYxRjblOVqPUdijSEoDExT0IhmuxWbveCpzhIu7SR4bpisW5p8tMJJMAxJ5WarVLoFMkOuRECIpsk16IEAFBL0sJUt+pXVZBHHPmAc61ARvJU+nga2Okv5OV1KkPNgh8ANFd0Yhd32DWUvjCvqv3c8G4IuiIPQ+jQXKoMpX8NKChAMq6FZ/LnVsdeGKclGrOV2g5KhAWhItut3UIFIG5CYTQOnpiWKiLPqIPdJNhX7mFfbjqmI6XqjDnd9eEXj0AzGP6jMxHs5BcEvR+UoHepmdH2C0qfaMOF2MNpqlQgWiXMGG0jCLKAMrMqd4ieiuDgtbRw2Li3a3DwPKdKh2wV+NFxVxldPJSoQwWAsHj75bxVqa006ZW0/qLQ5vYMnOolG/lcKS9SJnQBdKPwod8aPgv06mPnbiTqz/0SYX8RjqhmrF00AEmIG0FiY7wEIIxItzyPeGs4EbOdgHR+Dd3PCLPu2dVjToqKb2yguaimYMiwFPD/STryM19iFPuA8C8BalqGH4EBn9HGN964JvArSi/omLQhxg+N6R46u6P6uKW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8936002)(8676002)(5660300002)(26005)(41300700001)(2906002)(83380400001)(36756003)(2616005)(478600001)(38100700002)(316002)(86362001)(6506007)(53546011)(6486002)(66946007)(66556008)(66476007)(6666004)(4326008)(6916009)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?amgl9SKvDIYvEUw1kP7weqaZ9OOfm+SpaJD4EPZeefQzlc2/RyStdp29PlCM?=
 =?us-ascii?Q?d3DRuYismizzaCr9c/2Yhh8JxiTtKChEIOgWmpC+hGvj+/9LJpi19I90ACvl?=
 =?us-ascii?Q?LdaCazCAK6RHr3wLUjDHTUhXo+ncQaNCtkKMNsyJZ8PUu14+B3HSXnB0wSg1?=
 =?us-ascii?Q?I2qIUIyRdtBD39eVRLJqnmOXVwzFejTxz99d6GZLNSe67uWDeYzupTsTSLHJ?=
 =?us-ascii?Q?9AvJuPuZSsDlW0a80mTazPIumFEc+zkchdHXvZ59MywtRRo77wY5VVGfNPqx?=
 =?us-ascii?Q?JU8QHv65uW3fR736YPF/TLwXFnbjG8DRDGxzKUibTvYWO2PZ6Rav+fmQG5P1?=
 =?us-ascii?Q?B8hBtfAatGGVgP36hLJ3gcNGjC/dA+bRRA0DUYSE0GJN83EdRbDsv3AMlUQV?=
 =?us-ascii?Q?gS0Ra09lu92IsdjafM0mVudPDZqDs4akf8bNcsNdRiPQ8LS9xuL8WS6o6/OP?=
 =?us-ascii?Q?8eZQxiGXMetU8ON7DBHfSi+4NaulDrUm32U4+yjSbX5tr010gNzJTbAlTjfN?=
 =?us-ascii?Q?XnZr4BsTNm4ObHUIOqZwwCV2C0My0+anx3hIuoY3FtLwumgll7fyUhPPb2x+?=
 =?us-ascii?Q?p5joV4XJVnc5hhMRxuG/1V1zaLF3G1fNzxNlD53WtEpV8x+NQM5LI4RaqXOe?=
 =?us-ascii?Q?6yS39NUDEBdJHlxVuFxKashToSUZdF0Wwsw7JKimMl4Bj/eiY5C2hAuGwCnb?=
 =?us-ascii?Q?zBd5ZWd9pWjL2oNFgrsXWPnyegvwPimK+7p736DMi/6b1kTFowmFrLIM3C26?=
 =?us-ascii?Q?OqFt16rWgLbfy8gF8fhcHDofIj50gD69j1AGFC7kA+AhRsJaZC3HAJIUIiau?=
 =?us-ascii?Q?3b/96ACvhxq7F76v1zV1G5KqYoUIDsVOSmjuQEbJ6Ez5s/afS/sXdxkCVf/i?=
 =?us-ascii?Q?e9+KbIEFS5J4AaP03lqUrVVRlORagP0TQiK+wWxG5JQIzwIWX1LB7egS4Fn1?=
 =?us-ascii?Q?jgXvTkILukYXzPmVRMu9MUrMrxZNquHonf5KDvi4R6Vu6o1dfC7sX7612C+E?=
 =?us-ascii?Q?F1WpBJjFtDjEYPgPHGEgFv7x4j7+m32pQvlaHxvr8HqvKGehwpmhCiPPIptA?=
 =?us-ascii?Q?3hVNJkvnakP4PltmwzZvu8FuNcJlZI0fvXXd2bVsgLmf3SBZWyMHkiWRUJ63?=
 =?us-ascii?Q?MbXzZLX8YsOWYmC3X+12nuh+n3fdUKuXR0PcEeLQWDGnvI8ry/snUa3qXoYy?=
 =?us-ascii?Q?dNkJVrQrJNNKwffjQs6aWAnioREEQo3HSYbxNWAPZUVGVm6gyw3hlfrRL00S?=
 =?us-ascii?Q?hBKRbWFcxXw/dSPVIWzjoSD5CPofF80hWXi915uBtOmJlZwS4HnPeWSz1Nxl?=
 =?us-ascii?Q?jHQyOcBrv1B1ebw6Owd7GfR7Zui9t7QIfmqJyGFts7mC2t28Dn0SFKof+1hc?=
 =?us-ascii?Q?PRPXsym+UpKkljsU2RUQdzIFGnbj8N4yASHWRmkyVBSniIuHjAx2MdW6u7Hx?=
 =?us-ascii?Q?tsnH80ZA27djY6kabE1oruf5EbvTU+NuUgbZri1SOGBcZ9VwLhs27svlKaa+?=
 =?us-ascii?Q?PFDhJP2O5EeEPsG705ZPipo32wuDyav+16SwaTRVOYFPqjr3g03q2Lcc/jq+?=
 =?us-ascii?Q?/FfeDlali57GMtEfwVUSR9e2Lf7hIhoHZq+Oo/el?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be418fed-82d7-46ac-a680-08db9368dbfe
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 14:57:58.1410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hB4hPXVUibBLzPWbN/TJbuo3MxE2qD0Eo0kb72Idd8T98FolQ/if/Dat3VoEuUDR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8062
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 02, 2023 at 09:39:55AM -0500, Bob Pearson wrote:
> On 8/1/23 17:56, Jason Gunthorpe wrote:
> > On Mon, Jul 31, 2023 at 01:44:47PM -0500, Bob Pearson wrote:
> >> On 7/31/23 13:32, Jason Gunthorpe wrote:
> >>> On Mon, Jul 31, 2023 at 01:26:23PM -0500, Bob Pearson wrote:
> >>>> On 7/31/23 13:17, Jason Gunthorpe wrote:
> >>>>> On Fri, Jul 21, 2023 at 03:50:22PM -0500, Bob Pearson wrote:
> >>>>>> Network interruptions may cause long delays in the processing of
> >>>>>> send packets during which time the rxe driver may be unloaded.
> >>>>>> This will cause seg faults when the packet is ultimately freed as
> >>>>>> it calls the destructor function in the rxe driver. This has been
> >>>>>> observed in cable pull fail over fail back testing.
> >>>>>
> >>>>> No, module reference counts are only for code that is touching
> >>>>> function pointers.
> >>>>
> >>>> this is exactly the case here. it is the skb destructor function that
> >>>> is carried by the skb.
> >>>
> >>> It can't possibly call it correctly without also having the rxe
> >>> ib_device reference too though??
> >>
> >> Nope. This was causing seg faults in testing when there was a long network
> >> hang and the admin tried to reload the rxe driver. The skb code doesn't care
> >> about the ib device at all.
> > 
> > I don't get it, there aren't globals in rxe, so WTF is it doing if it
> > isn't somehow tracing back to memory that is under the ib_device
> > lifetime?
> > 
> > Jason
> 
> When the rxe driver builds a send packet it puts the address of its destructor
> subroutine in the skb before calling ip_local_out and sending it. The address of
> driver software is now hanging around. If you don't delay the module exit routine
> until all the skb's are freed you can cause seg faults. The only way to cause this to
> happen is to call rmmod on the driver too early but people have done this occasionally
> and report it as a bug.

You are missing the point, the destructor currently does this:

static void rxe_skb_tx_dtor(struct sk_buff *skb)
{
	struct sock *sk = skb->sk;
	struct rxe_qp *qp = sk->sk_user_data;

So you've already UAF'd because rxe_qp is freed memory well before you
get to unloading the module.

This series changed it to do this:
 
 static void rxe_skb_tx_dtor(struct sk_buff *skb)
 {
	struct rxe_dev *rxe;
	unsigned int index;
	struct rxe_qp *qp;
	int skb_out;

	/* takes a ref on ib device if success */
	rxe = get_rxe_from_skb(skb);
	if (!rxe)
		goto out;

 
static struct rxe_dev *get_rxe_from_skb(struct sk_buff *skb)
{
	struct rxe_dev *rxe;
	struct net_device *ndev = skb->dev;

	rxe = rxe_get_dev_from_net(ndev);
	if (!rxe && is_vlan_dev(ndev))
		rxe = rxe_get_dev_from_net(vlan_dev_real_dev(ndev));


Which seems totally nutz, you are now relying on the global hash table
in ib_core to resolve the ib device.

Again, why can't this code do something sane like refcount the qp or
ib_device so the destruction doesn't progress until all the SKBs are
flushed out?

Jason
