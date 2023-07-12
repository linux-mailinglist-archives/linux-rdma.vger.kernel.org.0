Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13D3750F0F
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jul 2023 18:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjGLQyc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 12:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjGLQyb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 12:54:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AD312E;
        Wed, 12 Jul 2023 09:54:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B02F616F1;
        Wed, 12 Jul 2023 16:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BF2C433C7;
        Wed, 12 Jul 2023 16:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689180864;
        bh=GUKIjZVgdEMfP7TDM1aNuHteDasdN91zxotPStZohNU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oAbNSVNXNIHr6DtuTw/oe0aFSsEtMyVVSR4TG6U7T5lLWYPueKmSeg4WlMWtBySra
         IlvvKmKpHIpVXeXMLRsPzCgrj4ePLxEznwuYSoG71a9NbS9p7CbfoFooV+jlDLFCBo
         0qJ44bbNZDYeJTtRA0EXhMU0zLv6vvqpxkw/TvH606c1ylZZcFlK35RupigexhX/Ch
         FmfvjTF6JvoucrTi1TDNzw0DzsXobsfGPq6iHnEDwTDhWBa+BKtSI+iB01eAGwudH4
         +IxLG/oc4nCJg7xMhoa5NGrame6QczA00+OGkxe5MEBNuQeZCCjE/ztY4AjtMQurmv
         8MFbVIxKStt2Q==
Date:   Wed, 12 Jul 2023 09:54:22 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc:     Jiri Pirko <jiri@resnulli.us>, "vadfed@meta.com" <vadfed@meta.com>,
        "jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "vadfed@fb.com" <vadfed@fb.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "M, Saeed" <saeedm@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "sj@kernel.org" <sj@kernel.org>,
        "javierm@redhat.com" <javierm@redhat.com>,
        "ricardo.canuelo@collabora.com" <ricardo.canuelo@collabora.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "Michalik, Michal" <michal.michalik@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jacek.lawrynowicz@linux.intel.com" 
        <jacek.lawrynowicz@linux.intel.com>,
        "airlied@redhat.com" <airlied@redhat.com>,
        "ogabbay@kernel.org" <ogabbay@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "nipun.gupta@amd.com" <nipun.gupta@amd.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux@zary.sk" <linux@zary.sk>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "Olech, Milena" <milena.olech@intel.com>,
        "kuniyu@amazon.com" <kuniyu@amazon.com>,
        "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "andy.ren@getcruise.com" <andy.ren@getcruise.com>,
        "razor@blackwall.org" <razor@blackwall.org>,
        "idosch@nvidia.com" <idosch@nvidia.com>,
        "lucien.xin@gmail.com" <lucien.xin@gmail.com>,
        "nicolas.dichtel@6wind.com" <nicolas.dichtel@6wind.com>,
        "phil@nwl.cc" <phil@nwl.cc>,
        "claudiajkang@gmail.com" <claudiajkang@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>,
        mschmidt <mschmidt@redhat.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
Subject: Re: [RFC PATCH v9 00/10] Create common DPLL configuration API
Message-ID: <20230712095422.00acaeaa@kernel.org>
In-Reply-To: <DM6PR11MB465701C009D1DC2972F900F29B36A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
        <ZJq3a6rl6dnPMV17@nanopsycho>
        <DM6PR11MB4657084DDD7554663F86C1C19B24A@DM6PR11MB4657.namprd11.prod.outlook.com>
        <ZJwWXZmZe4lQ04iK@nanopsycho>
        <DM6PR11MB4657751607C36FC711271D639B30A@DM6PR11MB4657.namprd11.prod.outlook.com>
        <ZKv1FRTXWLnLGRRS@nanopsycho>
        <DM6PR11MB46575D14FFE115546FDC9DEB9B31A@DM6PR11MB4657.namprd11.prod.outlook.com>
        <ZK1CizcqjqO1L/RQ@nanopsycho>
        <DM6PR11MB4657067EE043F4DBB9D8B03B9B31A@DM6PR11MB4657.namprd11.prod.outlook.com>
        <20230711131443.2a4af476@kernel.org>
        <DM6PR11MB465701C009D1DC2972F900F29B36A@DM6PR11MB4657.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 12 Jul 2023 09:19:53 +0000 Kubalewski, Arkadiusz wrote:
> >> Don't think it is way to go, and I don't think there is anything good
> >> with preventing device drivers from labeling their pins the way they
> >> want.  
> >
> >We had a long argument about how label should have a clearly defined
> >meaning. We're not going to rehash it on every revision. What did I miss :|  
> 
> Well, as I understand we are discussing if dpll subsystem shall prevent
> labeling the SyncE type pins. I have labeled them in ice explicitly with
> the name of a pci device they belong to.
> 
> You haven't miss much, mostly the problem is described in this thread.

Please read this thread:

https://lore.kernel.org/all/20230503191643.12a6e559@kernel.org/
