Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB3136948F
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Apr 2021 16:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbhDWOZK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Apr 2021 10:25:10 -0400
Received: from mail-mw2nam10on2048.outbound.protection.outlook.com ([40.107.94.48]:29025
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230520AbhDWOZJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Apr 2021 10:25:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwAUdTsTDQ/oofacxWM5F8AAn4sXAI0rFw51hFT0Ub433kybDqLF+ssY+GxXEBcbFErGUzk19DxT6nxQ5+AeACNf1JpiayQWlUPLYUzBfVwfVIhhel1jcslar6+p8SHpI4KSuOCTK46420aPltZfR8lqXyK1QV/mXcBrrouFZN0wHAa8Lip9yue/vzNXJvq2GQ0ZdYW0xm81wF/yMsspyJ8zn2Z0KJ5Nh6BHvLRYDh+KUeWz2f0awD7RgB8ac0yO8kYxXF0lvq2qtB0SYeYqMU1Ohh3cAPxD/GQMaaY940BUcxDk242nl0DTk1joIeQC6FmwTu+XfLj2thLottu5lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tAxkZj+yXRetLT+90Qe2GbMOXigPymAfDiTwTvzKeo=;
 b=YQKpYkSRS+vg7iEAKfHMk0m39Xp52SoQU9F6ZXLVV5qixJgoNrOBiQzfyhHRf/D/nmpccNITb6B69uHsxQzC7P20fLlY2m8dJjXFyD/M9cM1hJzugpXbPHfwkHiVb3yge6ZE8yYJXAp+aMMFYRPNQmkTCJ4w61mmt9L3pGKrgP2Wni8aj2HB6Yvf6Fme8gzHYULtt6ejZKrdtfowSN6iZcT6JcIyaPgJ6oD01hxl1YJd6+ii+6wqjU8Yw97JG86i3AV9eA9PivB7oKY+Ulbm72CPtI7AMsWWOYiETOxMint1467+1FBlft1lLpLn9M1NjyeyPjjc5BSld4Je2T/e6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tAxkZj+yXRetLT+90Qe2GbMOXigPymAfDiTwTvzKeo=;
 b=YNHFI1yBc/m9B2e4azEOEg0dIN2AKAdt8OFzSGGWFmxTI4O2JOBQyBquH53ka2oVpVJfT30WpfVAPi1u+FEx+Bi393ag8kQqDZb9lotAKxuDLaj6jK9WF9+b779W5HlNUoriRa6fwt93qdT82qoOjmgCdL8X+GAXQQjR6A5cIqxErzS/zVdWQogjjzrJmpipZqGwgPqKx58Qm5a+naKthIf3cHPf+m3sJ737+y20MaUcIypl5EZlJWtc9ByvTKIMCIVIb0QEgDn/292IIPm2UzIYk6YAdh6BktNjKHsqa0yS4SMrt2ZnD4BXZHKTF6o6P1syo4y+n57DU38DR4R6sA==
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 14:24:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.023; Fri, 23 Apr 2021
 14:24:32 +0000
Date:   Fri, 23 Apr 2021 11:24:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mark Zhang <markzhang@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 7/9] IB/cm: Clear all associated AV's ports
 when remove a cm device
Message-ID: <20210423142430.GI1370958@nvidia.com>
References: <cover.1619004798.git.leonro@nvidia.com>
 <00c97755c41b06af84f621a1b3e0e8adfe0771cc.1619004798.git.leonro@nvidia.com>
 <20210422193417.GA2435405@nvidia.com>
 <2eee42c7-04aa-eea1-f8a1-debf700ad0b0@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eee42c7-04aa-eea1-f8a1-debf700ad0b0@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR01CA0038.prod.exchangelabs.com (2603:10b6:208:23f::7)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR01CA0038.prod.exchangelabs.com (2603:10b6:208:23f::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Fri, 23 Apr 2021 14:24:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZwjO-00AbPh-DW; Fri, 23 Apr 2021 11:24:30 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2aaabdae-77f4-42ce-2c56-08d9066382d8
X-MS-TrafficTypeDiagnostic: DM6PR12MB2858:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB28583E202A30E604EC8A948CC2459@DM6PR12MB2858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DpVT6BYYd2Zay+wT/6Mxuoq5McAqGyZgjovU4kJXOuR1+hyZHErOCmqoa8XGs43e+7hLay7XchrMKeTxyVDZe0j99dIc5P35XwIn+bbE1W3TpKEZoyAffxwU/ihU3wjzoqB578Hlc8JBSZLwYDmHjT9AOFJtsW9CXu9ziTNFmKw25DjG3nOwi/Dkr0dKMHcowScvllTsCVUqwkw/oEVqOrZsIJhURSWf0MDKHoltkFZWxQTGR6Tt+HvpmDgiAZR1E1pv63KwVHJnp5xgCqLxh1vIsfMU+qmPtz+1xkLJGg/juJrPIVPeV2c5LadiycYwK3i7AbW4avYB6ZPhXf9505sdpC3stsN8cM4enuSvgtvWvzJiKJoWxfc+p9gG6vN76Luaifj5ly9MrCmwrJMQ++eWXO6Y14yUi50R/lBlWKZNQ66WjYQeJ7MJLKwVhTAImRQ3bLlXS5hCIBTxfp6fHI5ihN11snE8KGPzwHhkOfdmH2EOrzSeaR+eFQcSxFI77XwzS7rGF3jqp1igwZWtTDeMvhUTlRXVrY/1OZSlz+1tK71lnS14ge+2NjSdPjDi0cPuUXZ5PUhQdmnb149Q3ATyBbzOeTc/zBW2Q9fL6ao=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(33656002)(9746002)(9786002)(86362001)(316002)(83380400001)(26005)(6636002)(66476007)(1076003)(36756003)(37006003)(66556008)(5660300002)(8676002)(66946007)(6862004)(478600001)(4326008)(53546011)(2906002)(54906003)(426003)(186003)(8936002)(38100700002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JVxyRf6/wd6DdriEHiWCE8f6fL82jaeNz63qbJERwqrtUsvyKmwZJ0KC+URv?=
 =?us-ascii?Q?f6VD7VvjoJzgrV2Ldw0iWeKEtoWG5UNAIL6Q8j3nBWE42SnnC9nib5gqTZVL?=
 =?us-ascii?Q?4M3ptLCxn3+Syx2frvPZIqpWNZIKELd8Z92aUFy1trV2ZnVVbKfG3LUqJkli?=
 =?us-ascii?Q?hkuFqLNmVZyv8RvbEleBoqbCH0J1Yuh6BSQT73qQfZOQFOkW2O1rhJR9/m0o?=
 =?us-ascii?Q?SkHnFwNVDlEwXe8eGOpffew9BH87iVcxvBcEosEJv0Mfi6IVuJoZ0yEHXGT2?=
 =?us-ascii?Q?lrGwusSLSPlSJtt5ngHZBP8MRQcb7QL1NY2jMqje1sMNMKdBIeiQg3WQnH/d?=
 =?us-ascii?Q?ds34KiEFUeCPs+o2d/4It+tsLHznpVUTzOE408Ax41gRmpAGTMocLD73zuki?=
 =?us-ascii?Q?vrq7LRq/Wec42SV9QuOzVJJg8yhlPpjfuTB05577WOwjyZAtz9AOc6SWoJLn?=
 =?us-ascii?Q?Xu/O1rcTrOM77ucN7GCrO2wRA8IC6+OF+D15S0BZ6CVD7uITQyae1YJpeZ6A?=
 =?us-ascii?Q?79JB+Ofgozc+aP12ogyvjUujCfkorXICS+FcSn6Z2ZXucpvx6ZobNAbQl4y1?=
 =?us-ascii?Q?o+sVq+9NvWxoUU/F2ztwzcRuRAiQduhC6J1LDjD4bV7EknDSpUx39YxnFCwx?=
 =?us-ascii?Q?JVULJYlbNWmMx6Oo1LHmAEBAhbqckE4WsFedvsXZyv8zQ2vSkSzOFsBN4LqS?=
 =?us-ascii?Q?zX0etzgqQqiV25JlIjfLvkAPRDadnrH8TE050TXYEfrGGtTI6LIhYdoNpr4n?=
 =?us-ascii?Q?IgFGTSwva+0cSwtD8/7CZbV8AB3vXlGqtH75fVXBy6fL7uXJGW7znK2ZDkVg?=
 =?us-ascii?Q?Et1qN0hGLzg9Mi0swcVAhT3KIyp0aEnbR6WdVcMjsaDBLZkY82wwtSr9tSsw?=
 =?us-ascii?Q?TxPnevkzqIUozvcsBCjLPSC4RGFy0tKKDyTWrTtYDhxlpdN9NRvzIVB2/rb9?=
 =?us-ascii?Q?FsViMThZpm3pjmwjRdXv9NRun8pOWIVWPIFpiu3684D1GaPuhmmplDXgD8uF?=
 =?us-ascii?Q?rtAJJ39j4c1Jk34C69HPaF79cGsBafE1hgrp7mULw3mvRZvOeIk1nhhAbdX8?=
 =?us-ascii?Q?oLyb7APST06oJFcrVG2o5NApyjx3KIimO+jsfbdp6uAzTLkXz23Q9uWFhq+e?=
 =?us-ascii?Q?IfZZ3r3kycglAAkKJ9KTx4PXJBBjYiuCnuuiotyawdF56Gr2t8EadwiX7wwg?=
 =?us-ascii?Q?8BR9qHPv/SzqTdBIGaRipxZgD3eix+oIGGDPpsFTDuPHhvJ7RvfRLq6fk1DF?=
 =?us-ascii?Q?EvEC3Ak4+hmYu3GN4B7U/NGwlHnjyMQfoLEUD2UP4FKKPd7t1xWXLDbM+2J6?=
 =?us-ascii?Q?jZUcZkUFQQtj4wA70+SKWAr3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aaabdae-77f4-42ce-2c56-08d9066382d8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 14:24:31.9728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCkI2nEd0Xa1uSu6yRMIjINbUaD47tJfxYE5OcWgrwH3Oi8Wu9XKgzpPqDo1EIBp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2858
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 23, 2021 at 09:14:21PM +0800, Mark Zhang wrote:
> 
> 
> On 4/23/2021 3:34 AM, Jason Gunthorpe wrote:
> > On Wed, Apr 21, 2021 at 02:40:37PM +0300, Leon Romanovsky wrote:
> > > @@ -4396,6 +4439,14 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
> > >   	cm_dev->going_down = 1;
> > >   	spin_unlock_irq(&cm.lock);
> > > +	list_for_each_entry_safe(cm_id_priv, tmp,
> > > +				 &cm_dev->cm_id_priv_list, cm_dev_list) {
> > > +		if (!list_empty(&cm_id_priv->cm_dev_list))
> > > +			list_del(&cm_id_priv->cm_dev_list);
> > > +		cm_id_priv->av.port = NULL;
> > > +		cm_id_priv->alt_av.port = NULL;
> > > +	}
> > 
> > Ugh, this is in the wrong order, it has to be after the work queue
> > flush..
> > 
> > Hurm, I didn't see an easy way to fix it up, but I did think of a much
> > better design!
> > 
> > Generally speaking all we need is the memory of the cm_dev and port to
> > remain active, we don't need to block or fence with cm_remove_one(),
> > so just stick a memory kref on this thing and keep the memory. The
> > only things that needs to seralize with cm_remove_one() are on the
> > workqueue or take a spinlock (eg because they touch mad_agent)
> > 
> > Try this, I didn't finish every detail, applies on top of your series,
> > but you'll need to reflow it into new commits:
> 
> Thanks Jason, I think we still need a rwlock to protect "av->port"? It is
> modified and cleared by cm_set_av_port() and read in many places.

Hum..

This is a real mess.

It looks to me like any access to the av->port should always be
protected by the cm_id_priv->lock

Most already are, but the sets are wrong and a couple readers are wrong

Set reverse call chains:

cm_init_av_for_lap()
 cm_lap_handler(work) (ok)

cm_init_av_for_response()
 cm_req_handler(work) (OK, cm_id_priv is on stack)
 cm_sidr_req_handler(work) (OK, cm_id_priv is on stack)

cm_init_av_by_path()
 cm_req_handler(work) (OK, cm_id_priv is on stack)
 cm_lap_handler(work) (OK)
 ib_send_cm_req() (not locked)
   cma_connect_ib()
    rdma_connect_locked()
     [..]
   ipoib_cm_send_req()
   srp_send_req()
     srp_connect_ch()
      [..]
 ib_send_cm_sidr_req() (not locked)
  cma_resolve_ib_udp()
   rdma_connect_locked()

And
  cm_destroy_id() (locked)

And read reverse call chains:

cm_alloc_msg()
 ib_send_cm_req() (not locked)
 ib_send_cm_rep() (OK)
 ib_send_cm_rtu() (OK)
 cm_send_dreq_locked() (OK)
 cm_send_drep_locked() (OK)
 cm_send_rej_locked() (OK)
 ib_send_cm_mra() (OK)
 ib_send_cm_sidr_req() (not locked)
 cm_send_sidr_rep_locked() (OK)
cm_form_tid()
 cm_format_req()
  ib_send_cm_req() (sort of OK)
 cm_format_dreq()
   cm_send_dreq_locked (OK)
cm_format_req()
  ib_send_cm_req() (sort of OK)
cm_format_req_event()
 cm_req_handler() (OK, cm_id_priv is on stack)
cm_format_rep()
 ib_send_cm_rep() (OK)
cm_rep_handler(work) (OK)
cm_establish_handler(work) (OK)
cm_rtu_handler(work) (OK)
cm_send_dreq_locked() (OK)
cm_dreq_handler(work) (OK)
cm_drep_handler(work) (OK)
cm_rej_handler(work) (OK)
cm_mra_handler(work) (OK)
cm_apr_handler(work) (OK)
cm_sidr_rep_handler(work) (OK)
cm_init_qp_init_attr() (OK)
cm_init_qp_rtr_attr() (OK)
cm_init_qp_rts_attr() (OK)

So.. That leaves these functions that are not obviously locked
correctly:
 ib_send_cm_req()
 ib_send_cm_sidr_req()

And the way their locking expects to work is basically because they
expect that there are not parallel touches to the cm_id - however I'm
doubtful this is completely true.

So no new lock needed, but something should be done about the above
two functions, and this should be documented

Jason
