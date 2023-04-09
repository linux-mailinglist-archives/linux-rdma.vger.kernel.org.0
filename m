Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376CE6DBF68
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Apr 2023 12:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDIKHV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Apr 2023 06:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDIKHU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Apr 2023 06:07:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE08E269D
        for <linux-rdma@vger.kernel.org>; Sun,  9 Apr 2023 03:07:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B9B160B06
        for <linux-rdma@vger.kernel.org>; Sun,  9 Apr 2023 10:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67170C433EF;
        Sun,  9 Apr 2023 10:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681034838;
        bh=PHQeJJfO71CZkKTfCfKQEUKCNBRI9bLKHpaMfGJoKhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oecGPjge8OnG9caryX4UQrArj6iCHE5vIjp98uvOr2gPOmYLwpx9rsgAHR+uiLS56
         Es3eHxnXu+qBN2bokcwoC2JAuSlzRgUgVo99qSr0iF3+6D5DTZfw/YNBkCOkzb85O4
         I2fuNICwn4OqcTd4ASWx1HCijuzjjrnleAnNGxPxbHme1+11Rnvvwsy2ZEPQAkMAmp
         awZ6ppkNKwYBj774FRgOuDChFQCqDuSeRpUioLtchPNcLrZMv7CFsOuCS6+ItnSHmg
         wZtNLDWa3D13BmmTWEd0knJxo1z/Fj0U6Uqy1uyJd/kh1OU4QOuQlVhpBPh142AjFz
         m2SK7m7SRLNMQ==
Date:   Sun, 9 Apr 2023 13:07:15 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Saravanan Vajravel <saravanan.vajravel@broadcom.com>, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>
Subject: Re: [PATCH v2 for-rc] RDMA/srpt: Add a check for valid 'mad_agent'
 pointer
Message-ID: <20230409100715.GH14869@unreal>
References: <20230406042549.507328-1-saravanan.vajravel@broadcom.com>
 <659bfef6-c6d1-0316-60aa-215d8fd67c6a@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <659bfef6-c6d1-0316-60aa-215d8fd67c6a@acm.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 06, 2023 at 10:08:18AM -0700, Bart Van Assche wrote:
> On 4/5/23 21:25, Saravanan Vajravel wrote:
> > +		if (IS_ERR(mad_agent)) {
> >   			pr_err("%s-%d: MAD agent registration failed (%ld). Note: this is expected if SR-IOV is enabled.\n",
> >   			       dev_name(&sport->sdev->device->dev), sport->port,
> > -			       PTR_ERR(sport->mad_agent));
> > +			       PTR_ERR(mad_agent));
> >   			sport->mad_agent = NULL;
> >   			memset(&port_modify, 0, sizeof(port_modify));
> >   			port_modify.clr_port_cap_mask = IB_PORT_DEVICE_MGMT_SUP;
> >   			ib_modify_port(sport->sdev->device, sport->port, 0,
> >   				       &port_modify);
> > -
> > +		} else {
> > +			sport->mad_agent = mad_agent;
> >   		}
> >   	}
> 
> With an early return the 'else' clause wouldn't have been necessary. Anyway:
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Thanks, I fixed it locally and applied.
