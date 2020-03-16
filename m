Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04FF9186B56
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2020 13:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbgCPMq7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Mar 2020 08:46:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27201 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730970AbgCPMq7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Mar 2020 08:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584362816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c+wtvE8LQJtGJWBeJFzZphJZ5mN1eHogIW+xvpJmy00=;
        b=Gc29mI9yisHdmWLicE3LlDTEmASsMTC9oJZWh/H0WXz5ONrvhPnAWMm0UyoObm7rWSMdzf
        1bIY3PrPkTJbY6qvBHKTWn385+lNOeZBOUJKM26hZn4DP9K3pOzsSm169HdnfjkonYZckE
        VO6LRsuAR0KID71/nR9wXWEtsdBPPGQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-YPBmU44bNCWQuugguaHqRg-1; Mon, 16 Mar 2020 08:46:53 -0400
X-MC-Unique: YPBmU44bNCWQuugguaHqRg-1
Received: by mail-qv1-f71.google.com with SMTP id e16so16457972qvr.16
        for <linux-rdma@vger.kernel.org>; Mon, 16 Mar 2020 05:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c+wtvE8LQJtGJWBeJFzZphJZ5mN1eHogIW+xvpJmy00=;
        b=e1XEMwgoEc7+YTkz/w9jEVL+9djI1+K1v3hSG5A7bZgfRJCsvwUc+RlyE4hntRA3uX
         UNp3h3OVaJtIqL9rETYyR+HosewHUidPhJ8EsLHSLMyvWLJ93BMK2xr9S2DRpB9Z4V0x
         Flrya+TyC1M+7N91D29j4Xz4ExgOyWJe5tMxgkXwoXP+26YgBW7K5Ex0KOTMdfu3qWE2
         m8yvAswKbBOr9ZoL0cNLoUMnSv/PXfVVNl7ZivBm7t2b5B9tlNzEEEUME9XDxUQRd8sY
         Ls3eol0lws8jzjVjL8sgtijuRcAGADG9t+4ClTTC+wXWDk4NHWlgRMlWCtpSCiXJ5LUX
         M4Qw==
X-Gm-Message-State: ANhLgQ113EUeGh9EgugdmB7AV9IAzdusQhk0zFeV7tKuavCTFhf5ZO/0
        zodEtY5BO/VHdzQl33YzsT59MzZX8sSKpWmH9fEGY2DATL7AcJC4NfMIofoIcFQ+boHQLkrGtZz
        sECWnUGWXUGgR/U9USAbzbQ==
X-Received: by 2002:ae9:eb0e:: with SMTP id b14mr23622896qkg.283.1584362812770;
        Mon, 16 Mar 2020 05:46:52 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vun+KCp+4gJobvTtYbPlmo80SOs9uDy/I22pmfjapKinAt1zgCQ099mfQVsdKQ4ebH040zUBw==
X-Received: by 2002:ae9:eb0e:: with SMTP id b14mr23622855qkg.283.1584362812240;
        Mon, 16 Mar 2020 05:46:52 -0700 (PDT)
Received: from loberhel7laptop ([2600:6c64:4e80:f1:4a17:2cf9:6a8a:f150])
        by smtp.gmail.com with ESMTPSA id d19sm4095859qkc.14.2020.03.16.05.46.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2020 05:46:51 -0700 (PDT)
Message-ID: <0a0c90381e1d8a762b06e1128413272fbc63c971.camel@redhat.com>
Subject: Re: commit ab118da4c10a70b8437f5c90ab77adae1835963e causes ib_srpt
 to fail connections served by target LIO
From:   Laurence Oberman <loberman@redhat.com>
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>,
        rdmadev <rdma-dev-team@redhat.com>, linux-rdma@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "Van Assche, Bart" <bvanassche@acm.org>,
        Rupesh Girase <rgirase@redhat.com>
Date:   Mon, 16 Mar 2020 08:46:50 -0400
In-Reply-To: <20200316073002.GE8510@unreal>
References: <88bab94d2fd72f3145835b4518bc63dda587add6.camel@redhat.com>
         <0bef0089-0c46-8fb7-9e44-61654c641cbd@mellanox.com>
         <e57c1763dd99ea958c9834a53ae5688a775c9444.camel@redhat.com>
         <6d5415e3-9314-331a-fade-7593c6a27290@mellanox.com>
         <8695fb0f34588616aded629127cc3fa2799fa7cb.camel@redhat.com>
         <918bc803-41d6-6eea-34e2-9e40f959a982@mellanox.com>
         <2a04cd1d66e6bc2edb96231b47499f4c1450e592.camel@redhat.com>
         <327df8af71afab4a2f9b6da804218d5a94cf6020.camel@redhat.com>
         <20200316072140.GD8510@unreal> <20200316073002.GE8510@unreal>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-5.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 2020-03-16 at 09:30 +0200, Leon Romanovsky wrote:
> On Mon, Mar 16, 2020 at 09:21:40AM +0200, Leon Romanovsky wrote:
> > On Sun, Mar 15, 2020 at 05:56:17PM -0400, Laurence Oberman wrote:
> > > On Sun, 2020-03-15 at 17:01 -0400, Laurence Oberman wrote:
> > > > On Sun, 2020-03-15 at 22:40 +0200, Max Gurtovoy wrote:
> > > > > On 3/15/2020 8:36 PM, Laurence Oberman wrote:
> > > > > > On Sun, 2020-03-15 at 20:20 +0200, Max Gurtovoy wrote:
> > > > > > > On 3/15/2020 7:59 PM, Laurence Oberman wrote:
> > > > > > > > On Sun, 2020-03-15 at 18:47 +0200, Max Gurtovoy wrote:
> > > > > > > > > On 3/14/2020 11:30 PM, Laurence Oberman wrote:
> > > > > > > > > > Hello Bart, Leon and Max
> > > > > > > > > 
> > > > > > > > > Hi Laurence,
> > > > > > > > > 
> > > > > > > > > thanks for the great analysis and the fast response
> > > > > > > > > !!
> > > > > > > > > 
> > > > > > > > > > Max had reached out to me to test a new set of
> > > > > > > > > > patches
> > > > > > > > > > for
> > > > > > > > > > SRQ.
> > > > > > > > > > I had not tested upstream ib_srpt on an LIO target
> > > > > > > > > > for
> > > > > > > > > > quite a
> > > > > > > > > > while,
> > > > > > > > > > only ib_srp client tests had been run of late.
> > > > > > > > > > During a baseline test before applying Max's
> > > > > > > > > > patches it
> > > > > > > > > > was
> > > > > > > > > > apparent
> > > > > > > > > > that something had broken ib_srpt connections
> > > > > > > > > > within LIO
> > > > > > > > > > target
> > > > > > > > > > since
> > > > > > > > > > 5.5.
> > > > > > > > > > 
> > > > > > > > > > Note thet ib_srp client connectivity with the
> > > > > > > > > > commit
> > > > > > > > > > functions
> > > > > > > > > > fine,
> > > > > > > > > > it's just the target that breaks with this commit.
> > > > > > > > > > 
> > > > > > > > > > After a long bisect this is the commit that seems
> > > > > > > > > > to
> > > > > > > > > > break
> > > > > > > > > > it.
> > > > > > > > > > While it's not directly code in ib_srpt, its code
> > > > > > > > > > in mlx5
> > > > > > > > > > vport
> > > > > > > > > > ethernet connectivity that then breaks ib_srpt
> > > > > > > > > > connectivity
> > > > > > > > > > over
> > > > > > > > > > mlx5
> > > > > > > > > > IB RDMA with LIO.
> > > > > > > > > 
> > > > > > > > > I was able to connect in loopback and also from
> > > > > > > > > remote
> > > > > > > > > initiator
> > > > > > > > > with
> > > > > > > > > this commit.
> > > > > > > > > 
> > > > > > > > > So I'm not sure that this commit is broken.
> > > > > > > > > 
> > > > > > > > > I used Bart's scripts to configure the target and to
> > > > > > > > > connect
> > > > > > > > > to
> > > > > > > > > it
> > > > > > > > > in
> > > > > > > > > loopback (after some modifications for the updated
> > > > > > > > > kernel/sysfs/configfs
> > > > > > > > > interface).
> > > > > > > > > 
> > > > > > > > > I did see an issue to connect from remote initiator,
> > > > > > > > > but
> > > > > > > > > after
> > > > > > > > > reloading
> > > > > > > > > openibd in the initiator side I was able to connect.
> > > > > > > > > 
> > > > > > > > > So I suspect you had the same issue - that also
> > > > > > > > > should be
> > > > > > > > > debugged.
> > > > > > > > > 
> > > > > > > > > > I will let Leon and others decide but reverting the
> > > > > > > > > > below
> > > > > > > > > > commit
> > > > > > > > > > allows
> > > > > > > > > > SRP connectivity to an LIO target to work again.
> > > > > > > > > 
> > > > > > > > > I added prints to
> > > > > > > > > "mlx5_core_modify_hca_vport_context"
> > > > > > > > > function
> > > > > > > > > and
> > > > > > > > > found that we don't call it in "pure" mlx5 mode with
> > > > > > > > > PFs.
> > > > > > > > > 
> > > > > > > > > Maybe you can try it too...
> > > > > > > > > 
> > > > > > > > > I was able to check my patches on my system and I'll
> > > > > > > > > send
> > > > > > > > > them
> > > > > > > > > soon.
> > > > > > > > > 
> > > > > > > > > Thanks again Laurence and Bart.
> > > > > > > > > 
> > > > > > > > > > Max, I will test your new patches once we have a
> > > > > > > > > > decision
> > > > > > > > > > on
> > > > > > > > > > this.
> > > > > > > > > > 
> > > > > > > > > > Client
> > > > > > > > > > Linux ibclient.lab.eng.bos.redhat.com 5.6.0-rc5+ #1
> > > > > > > > > > SMP
> > > > > > > > > > Thu
> > > > > > > > > > Mar
> > > > > > > > > > 12
> > > > > > > > > > 16:58:19 EDT 2020 x86_64 x86_64 x86_64 GNU/Linux
> > > > > > > > > > 
> > > > > > > > > > Server with reverted commit
> > > > > > > > > > Linux fedstorage.bos.redhat.com 5.6.0-rc5+ #1 SMP
> > > > > > > > > > Sat Mar
> > > > > > > > > > 14
> > > > > > > > > > 16:39:35
> > > > > > > > > > EDT 2020 x86_64 x86_64 x86_64 GNU/Linux
> > > > > > > > > > 
> > > > > > > > > > commit ab118da4c10a70b8437f5c90ab77adae1835963e
> > > > > > > > > > Author: Leon Romanovsky <leonro@mellanox.com>
> > > > > > > > > > Date:   Wed Nov 13 12:03:47 2019 +0200
> > > > > > > > > > 
> > > > > > > > > >        net/mlx5: Don't write read-only fields in
> > > > > > > > > > MODIFY_HCA_VPORT_CONTEXT
> > > > > > > > > > command
> > > > > > > > > > 
> > > > > > > > > >        The MODIFY_HCA_VPORT_CONTEXT uses
> > > > > > > > > > field_selector
> > > > > > > > > > to
> > > > > > > > > > mask
> > > > > > > > > > fields
> > > > > > > > > > needed
> > > > > > > > > >        to be written, other fields are required to
> > > > > > > > > > be
> > > > > > > > > > zero
> > > > > > > > > > according
> > > > > > > > > > to
> > > > > > > > > > the
> > > > > > > > > >        HW specification. The supported fields are
> > > > > > > > > > controlled by
> > > > > > > > > > bitfield
> > > > > > > > > >        and limited to vport state, node and port
> > > > > > > > > > GUIDs.
> > > > > > > > > > 
> > > > > > > > > >        Signed-off-by: Leon Romanovsky <
> > > > > > > > > > leonro@mellanox.com>
> > > > > > > > > >        Signed-off-by: Saeed Mahameed <
> > > > > > > > > > saeedm@mellanox.com
> > > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > diff --git
> > > > > > > > > > a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> > > > > > > > > > b/drivers/net/ethernet/mellanox/mlx5
> > > > > > > > > > index 30f7848..1faac31f 100644
> > > > > > > > > > ---
> > > > > > > > > > a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> > > > > > > > > > +++
> > > > > > > > > > b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> > > > > > > > > > @@ -1064,26 +1064,13 @@ int
> > > > > > > > > > mlx5_core_modify_hca_vport_context(struct
> > > > > > > > > > mlx5_core_dev *dev,
> > > > > > > > > > 
> > > > > > > > > >            ctx =
> > > > > > > > > > MLX5_ADDR_OF(modify_hca_vport_context_in,
> > > > > > > > > > in,
> > > > > > > > > > hca_vport_context);
> > > > > > > > > >            MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > field_select,
> > > > > > > > > > req-
> > > > > > > > > > > field_select);
> > > > > > > > > > 
> > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > sm_virt_aware,
> > > > > > > > > > req-
> > > > > > > > > > > sm_virt_aware);
> > > > > > > > > > 
> > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx, has_smi,
> > > > > > > > > > req-
> > > > > > > > > > > has_smi);
> > > > > > > > > > 
> > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx, has_raw,
> > > > > > > > > > req-
> > > > > > > > > > > has_raw);
> > > > > > > > > > 
> > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > vport_state_policy,
> > > > > > > > > > req-
> > > > > > > > > > > policy);
> > > > > > > > > > 
> > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > port_physical_state,
> > > > > > > > > > req-
> > > > > > > > > > > phys_state);
> > > > > > > > > > 
> > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > vport_state,
> > > > > > > > > > req-
> > > > > > > > > > > vport_state);
> > > > > > > > > > 
> > > > > > > > > > -       MLX5_SET64(hca_vport_context, ctx,
> > > > > > > > > > port_guid,
> > > > > > > > > > req-
> > > > > > > > > > > port_guid);
> > > > > > > > > > 
> > > > > > > > > > -       MLX5_SET64(hca_vport_context, ctx,
> > > > > > > > > > node_guid,
> > > > > > > > > > req-
> > > > > > > > > > > node_guid);
> > > > > > > > > > 
> > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx, cap_mask1,
> > > > > > > > > > req-
> > > > > > > > > > > cap_mask1);
> > > > > > > > > > 
> > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > cap_mask1_field_select,
> > > > > > > > > > req-
> > > > > > > > > > > cap_mask1_perm);
> > > > > > > > > > 
> > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx, cap_mask2,
> > > > > > > > > > req-
> > > > > > > > > > > cap_mask2);
> > > > > > > > > > 
> > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > cap_mask2_field_select,
> > > > > > > > > > req-
> > > > > > > > > > > cap_mask2_perm);
> > > > > > > > > > 
> > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx, lid, req-
> > > > > > > > > > >lid);
> > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > init_type_reply,
> > > > > > > > > > req-
> > > > > > > > > > > init_type_reply);
> > > > > > > > > > 
> > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx, lmc, req-
> > > > > > > > > > >lmc);
> > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > subnet_timeout,
> > > > > > > > > > req-
> > > > > > > > > > > subnet_timeout);
> > > > > > > > > > 
> > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx, sm_lid,
> > > > > > > > > > req-
> > > > > > > > > > > sm_lid);
> > > > > > > > > > 
> > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx, sm_sl,
> > > > > > > > > > req-
> > > > > > > > > > > sm_sl);
> > > > > > > > > > 
> > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > qkey_violation_counter,
> > > > > > > > > > req-
> > > > > > > > > > > qkey_violation_counter);
> > > > > > > > > > 
> > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > pkey_violation_counter,
> > > > > > > > > > req-
> > > > > > > > > > > pkey_violation_counter);
> > > > > > > > > > 
> > > > > > > > > > +       if (req->field_select &
> > > > > > > > > > MLX5_HCA_VPORT_SEL_STATE_POLICY)
> > > > > > > > > > +               MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > vport_state_policy,
> > > > > > > > > > +                        req->policy);
> > > > > > > > > > +       if (req->field_select &
> > > > > > > > > > MLX5_HCA_VPORT_SEL_PORT_GUID)
> > > > > > > > > > +               MLX5_SET64(hca_vport_context, ctx,
> > > > > > > > > > port_guid,
> > > > > > > > > > req-
> > > > > > > > > > > port_guid);
> > > > > > > > > > 
> > > > > > > > > > +       if (req->field_select &
> > > > > > > > > > MLX5_HCA_VPORT_SEL_NODE_GUID)
> > > > > > > > > > +               MLX5_SET64(hca_vport_context, ctx,
> > > > > > > > > > node_guid,
> > > > > > > > > > req-
> > > > > > > > > > > node_guid);
> > > > > > > > > > 
> > > > > > > > > >            err = mlx5_cmd_exec(dev, in, in_sz, out,
> > > > > > > > > > sizeof(out));
> > > > > > > > > >     ex:
> > > > > > > > > >            kfree(in);
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > 
> > > > > > > > Hi Max
> > > > > > > > Re:
> > > > > > > > 
> > > > > > > > "
> > > > > > > > So I'm not sure that this commit is broken.
> > > > > > > > ..
> > > > > > > > ..
> > > > > > > > I added prints to "mlx5_core_modify_hca_vport_context"
> > > > > > > > function
> > > > > > > > and
> > > > > > > > found that we don't call it in "pure" mlx5 mode with
> > > > > > > > PFs.
> > > > > > > > 
> > > > > > > > Maybe you can try it too...
> > > > > > > > "
> > > > > > > > 
> > > > > > > > The thing is without this commit we connect
> > > > > > > > immediately, no
> > > > > > > > delay
> > > > > > > > no
> > > > > > > > issue and I am changing nothing else other than
> > > > > > > > reverting
> > > > > > > > here.
> > > > > > > > 
> > > > > > > > So this clearly has a bearing directly on the
> > > > > > > > functionality.
> > > > > > > > 
> > > > > > > > I will look at adding more debug, but with this commit
> > > > > > > > in
> > > > > > > > there
> > > > > > > > is
> > > > > > > > nor
> > > > > > > > evidence even of an attempt to connect and fail.
> > > > > > > > 
> > > > > > > > Its silently faling.
> > > > > > > 
> > > > > > > please send me all the configuration steps you run after
> > > > > > > booting
> > > > > > > the
> > > > > > > target + steps in the initiator (can be also in attached
> > > > > > > file).
> > > > > > > 
> > > > > > > I'll try to follow this.
> > > > > > > 
> > > > > > > Btw, did you try loopback initiator ?
> > > > > > > 
> > > > > > > -Max.
> > > > > > > 
> > > > > > > 
> > > > > > > > Regards
> > > > > > > > Laurence
> > > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > 
> > > > > > Hi Max
> > > > > > 
> > > > > > Did not try loopback because here we have actual physical
> > > > > > connectity as
> > > > > > that is what our customers use.
> > > > > > 
> > > > > > Connected back to back with MLX5 cx4 HCA dual ports at EDR
> > > > > > 100
> > > > > > Thi sis my standard configuration used for all upstream and
> > > > > > Red
> > > > > > Hat
> > > > > > kernel testing.
> > > > > > 
> > > > > > Reboot server and client and then first prepare server
> > > > > > 
> > > > > > Server
> > > > > > ----------
> > > > > > 
> > > > > > the prepare.sh script run is after boot on the server
> > > > > > 
> > > > > > 
> > > > > > #!/bin/bash
> > > > > > ./load_modules.sh
> > > > > > ./create_ramdisk.sh
> > > > > > targetcli restoreconfig
> > > > > > # Set the srp_sq_size
> > > > > > for i in
> > > > > > /sys/kernel/config/target/srpt/0xfe800000000000007cfe900300
> > > > > > 726e4e
> > > > > > /sys/kernel/config/target/srpt/0xfe800000000000007cfe900300
> > > > > > 726e4f
> > > > > > do
> > > > > > 	echo 16384 > $i/tpgt_1/attrib/srp_sq_size
> > > > > > done
> > > > > > 
> > > > > > [root@fedstorage ~]# cat load_modules.sh
> > > > > > #!/bin/bash
> > > > > > modprobe mlx5_ib
> > > > > > modprobe ib_srpt
> > > > > > modprobe ib_srp
> > > > > > modprobe ib_umad
> > > > > > 
> > > > > > [root@fedstorage ~]# cat ./create_ramdisk.sh
> > > > > > #!/bin/bash
> > > > > > mount -t tmpfs -o size=130g tmpfs /mnt
> > > > > > cd /mnt
> > > > > > for i in `seq 1 30`; do dd if=/dev/zero of=block-$i
> > > > > > bs=1024k
> > > > > > count=4000
> > > > > > ; done
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > Client
> > > > > > --------
> > > > > > 
> > > > > > Once server is ready
> > > > > > 
> > > > > > Run ./start_opensm.sh on client (I sont use the SM on a
> > > > > > switch as
> > > > > > we
> > > > > > are back to back)
> > > > > > 
> > > > > > [root@ibclient ~]# cat ./start_opensm.sh
> > > > > > #!/bin/bash
> > > > > > rmmod ib_srpt
> > > > > > opensm -F opensm.1.conf &
> > > > > > opensm -F opensm.2.conf &
> > > > > > 
> > > > > > I will semail the conf only to you as well as the targecli
> > > > > > config
> > > > > > as th
> > > > > > eout is long.
> > > > > > 
> > > > > > 
> > > > > > Then run start_srp.sh
> > > > > > 
> > > > > > [root@ibclient ~]# cat ./start_srp.sh
> > > > > > run_srp_daemon  -V -f /etc/ddn/srp_daemon.conf -R 30 -T 10
> > > > > > -t
> > > > > > 7000
> > > > > > -ance -i mlx5_0 -p 1 1>/root/srp1.log 2>&1 &
> > > > > > run_srp_daemon  -V -f /etc/ddn/srp_daemon.conf -R 30 -T 10
> > > > > > -t
> > > > > > 7000
> > > > > > -ance -i mlx5_1 -p 1 1>/root/srp2.log 2>&1 &
> > > > > > 
> > > > > > [root@ibclient ~]# cat /etc/ddn/srp_daemon.conf
> > > > > > a      queue_size=128,max_cmd_per_lun=32,max_sect=32768
> > > > > > 
> > > > > > 
> > > > > 
> > > > > I see that you're link is IB.
> > > > > 
> > > > > I was working on RoCE link layer with rdma_cm.
> > > > > 
> > > > > I'll try to find some free IB setup tomorrow in my lab..
> > > > > 
> > > > > Can you try login using rdma_cm ? need to load ib_ipoib for
> > > > > that in
> > > > > IB
> > > > > network.
> > > > > 
> > > > > I'm trying to understand whether it's related to the link
> > > > > layer.
> > > > > 
> > > > > p.s. I think the target configuration file didn't arrive.
> > > > > 
> > > > > > 
> > > > > > 
> > > > > 
> > > > > 
> > > > 
> > > > Max,
> > > > 
> > > > Yes, I am, working primarily with SCSI over RDMA Protocol with
> > > > Infiniband HCA's in IB mode.
> > > > I am not using ROCE.
> > > > 
> > > > Also lets not forget this is a target only issue, the latest
> > > > 5.6
> > > > kernel
> > > > runs untouched with no issues on the initiator when the target
> > > > runs
> > > > either 5.4 or 5.6 with the revert.
> > > > It would run fine with the target on 5.5 as well if I reverted
> > > > the
> > > > commit on 5.5 too.
> > > > 
> > > > I am not able at this time to switch these adapters to Ethernet
> > > > mode
> > > > and ROCE
> > > > 
> > > > The weird thing is the failure is completely silent so
> > > > something in
> > > > the
> > > > Link layer with IB has to failing early.
> > > > Thje other strange observation is that the IB interfaces come
> > > > up with
> > > > no issue.
> > > > I will try add some debug after reboot into the failing kernel.
> > > > 
> > > > Regards
> > > > Laurence
> > > > 
> > > > 
> > > > 
> > > 
> > > Max,
> > > Rupesh in cc here will be testing latest upstream on a
> > > client/server
> > > configuration with ROCE and report back here on if he sees a
> > > similar
> > > issue with the LIO target with that commit.
> > > 
> > > I will continue working on the IB srpt issue by adding some
> > > debug.
> > > 
> > > If you think about anything related to the commit let me know.
> > 
> > Laurence,
> > 
> > As I said above, the most chances are that I removed some RW
> > initialization that wasn't protected by field_select and wasn't
> > marked in our PRM as RW field.
> > 
> > The question is which one.
> 
> I think that I know what is missing.
> Can you please try this patch?
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> index 1faac31f74d0..23f879da9104 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> @@ -1071,6 +1071,9 @@ int mlx5_core_modify_hca_vport_context(struct
> mlx5_core_dev *dev,
>                 MLX5_SET64(hca_vport_context, ctx, port_guid, req-
> >port_guid);
>         if (req->field_select & MLX5_HCA_VPORT_SEL_NODE_GUID)
>                 MLX5_SET64(hca_vport_context, ctx, node_guid, req-
> >node_guid);
> +       MLX5_SET(hca_vport_context, ctx, cap_mask1, req->cap_mask1);
> +       MLX5_SET(hca_vport_context, ctx, cap_mask1_field_select,
> +                req->cap_mask1_perm);
>         err = mlx5_cmd_exec(dev, in, in_sz, out, sizeof(out));
>  ex:
>         kfree(in);
> 
> 
> > 
> > Thanks
> > 
> > > 
> > > Regards
> > > Laurence
> > > 
> 
> 

Trying that now and will report back

