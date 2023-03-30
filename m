Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8764D6D1361
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Mar 2023 01:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjC3XjU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 19:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjC3XjS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 19:39:18 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B644EA27A
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 16:39:17 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id m16so15262741qvi.12
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 16:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1680219557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ySdXcyCl4jss1/HoCykrtGsTlf7azWh5rmfqZoRs+c=;
        b=G9wN/HHm6gvzmfhV3SBS2/U+SW40WZ+TUfZVES/A7lG/tLtvdl9JOcF1Gezf4ZY1Wb
         y4fk8hEWu2mKrgHI0DJDoZILiQsTT5HJk4S9fu1FXpuKmuylouuyAwjiq6s6YEEeVegr
         cacB2GI1D58DEev390xU14Ixr/xrT0OQffC/s1YO9L6RCCyrzzHw9bV81LeT2miqkLAq
         czsQyfNvArHcRV+ZSRZ/fteaJuFhGma29goWPgNKI5XnPt4d+NvLGQ7dywvufMjNSJUC
         qroPZJvuWYtXsVcbi6Rfypwtri43W4TQoMeAQEXTOqJU4fF1IYOlyGXH6tNFtpt/dKTr
         we1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680219557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ySdXcyCl4jss1/HoCykrtGsTlf7azWh5rmfqZoRs+c=;
        b=j59WpwCovh7xuiTcd8HWqZlWAc6PBS52SO1WF3f3+9cA9UIeQOukgrD/bUBzdv8Ssa
         d4XnqN8lDldgXe4TiAMjAu2obrJ3uryh5XXC+LTK+yUWLowxroPw1CmmVFyxwopmQH2n
         jbxHRX023LCN0naQ/NoU7La1NkA2QnBzvxAu2hFH+kGRuI+vgZh78QqwKHO8+pH1yV2M
         3o9IOgWyKpo18v2wQwZWYUMn0WXWyLyDO8e+44L70jVSeqAh6s718yMdFmMm3LNBguW3
         x4InqFP24LPgjzI7K//Ko89gJMbKVmkrN/Xu0bude64l9nhvFM/vnne/POxRIxksFhfJ
         PNIA==
X-Gm-Message-State: AAQBX9dXxq3dCVSp2rVs+1n49ov1/rxEd84Sg66t+gFzyAvbgegdM43z
        HrvUAzApJP1ubu2s3kzTrJGoKE8oa77Cw/3IO4A=
X-Google-Smtp-Source: AKy350ZtocP6HQMspn4mTiZQ807RDdc9KCBZC31jC3xHthPIg267UdmU/1VyXRineUV/FY7YtidPhA==
X-Received: by 2002:a05:6214:240a:b0:56e:f9a2:3eba with SMTP id fv10-20020a056214240a00b0056ef9a23ebamr44679064qvb.41.1680219556843;
        Thu, 30 Mar 2023 16:39:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id dg15-20020a056214084f00b005dd8b9345afsm191821qvb.71.2023.03.30.16.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 16:39:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pi1rP-005CNR-CM;
        Thu, 30 Mar 2023 20:39:15 -0300
Date:   Thu, 30 Mar 2023 20:39:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA: don't ignore client->add() failures
Message-ID: <ZCYdo8pcS947JOgI@ziepe.ca>
References: <0e031582-aed6-58ee-3477-6d787f06560a@I-love.SAKURA.ne.jp>
 <ZCLOYznKQQKfoqzI@ziepe.ca>
 <a9960371-ef94-de6e-466f-0922a5e3acf3@I-love.SAKURA.ne.jp>
 <ZCLQ0XVSKVHV1MB2@ziepe.ca>
 <ec025592-3390-cf4f-ed03-c3c6c43d9310@I-love.SAKURA.ne.jp>
 <ZCMTZWdY7D7mxJuE@ziepe.ca>
 <d2dfb901-50b1-8e34-8217-d29e63f421c7@I-love.SAKURA.ne.jp>
 <ZCRc5S9QGZqcZhNg@ziepe.ca>
 <9186f5f5-2f88-1247-2d24-61d090a1da83@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9186f5f5-2f88-1247-2d24-61d090a1da83@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 30, 2023 at 08:51:44AM +0900, Tetsuo Handa wrote:
> On 2023/03/30 0:44, Jason Gunthorpe wrote:
> >> The caller of ib_register_device() (i.e. siw_device_register() from
> >> siw_newlink()) is assuming that somebody will call __ib_unregister_device(),
> >> but nobody is calling __ib_unregister_device().
> > 
> > On the success path this stuff happens during dellink
> > 
> 
> "struct rdma_link_ops" has "newlink" callback but does not have "dellink" callback.
> "struct rtnl_link_ops" has both "newlink" callback and "dellink" callback, but
> only ipoib_netlink.c defines it inside drivers/infiniband/ directory.
> 
> Where is the dellink you are talking about?
> I'm not familiar with rdma code. Please explain using specific function/symbol names.

Your test code deletes a vlan

If SIW is attached to a vlan then SIW will destroy itself based on a
net notifier

Look at siw_netdev_event:

	case NETDEV_UNREGISTER:
		ib_unregister_device_queued(&sdev->base_dev);
		break;

Jason
