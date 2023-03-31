Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D9B6D2579
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Mar 2023 18:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjCaQ3C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Mar 2023 12:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjCaQ2u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 Mar 2023 12:28:50 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02F22BEC5
        for <linux-rdma@vger.kernel.org>; Fri, 31 Mar 2023 09:24:30 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id t13so16750411qvn.2
        for <linux-rdma@vger.kernel.org>; Fri, 31 Mar 2023 09:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1680279814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gOvtk4fTPu3cA/Z4LuQWfzQ/ZQig6kQxnH99hLgyu9k=;
        b=jG2PeLcjx0O3+8NKi1n9W7NPJMmPlWP12mSStHW/eOavnBa3nHIN2vslutXEc+Yxpy
         JMAKhFWirKGxLSh8rSih2+8sQ5IC+JqQmUj9TpFLL9qe/HBowyd1kEtbEiV0NqcQhSDo
         Tm9wIKKJxEdVq794HgX6DTv8pAz2PcMRjRuZyi80MFuz98pY1Um9ZKhAD/vvY/VnAaKa
         Scw1aaUPaJbFPw59FlSrALUEUqwUsfF6rSjL8Ab53pBRsxCjz2ZuMJ95D1XunQ6hLxum
         WTICYnV6d5e8f58BDP/aOzAdit99WHMYupH6NcGHNTOzEoxpF8RLCkQjLH89MtqK4Svn
         9xgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680279814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOvtk4fTPu3cA/Z4LuQWfzQ/ZQig6kQxnH99hLgyu9k=;
        b=fFIBIoxaD3JyfgdYK+KyiRIMR5XPyg2E/ZWWyYRVnkOvR09nV78uBe/iCH9yOf8CsK
         ZnmVjr8lbt6GoDvIOsRW0Mx/A7M9PqXPBKRDTz/u9Kp6ilLKgjO4h1NHme0Ry103YE3d
         n2MhRSMFS0gXtOj/wE7Oyjd8JSROewENu+3kZQ6hsqKBBzEs2jm+hP3AcUWdtY9YuNfd
         vyKMNx/OaTVAqD1LZ0OW13ukrAyL/D2cgzyQsBUIZ1dr/LcKniNNT53PlXu2v6GombSV
         EXwKYeN3zrQElDp0+Dl7WHo4kayVV8EPqTkKSlUtg42dpds6ous96jXTLhBbwqTFQp4U
         p77w==
X-Gm-Message-State: AAQBX9exrKDcGA+HibhhiuDa13TL81O0OZ7xr9rGT0aO2URlp37BcqRE
        VsLQMfNfkXjtSHmV+bpiMVNTqGDYxRnms1PLqFk=
X-Google-Smtp-Source: AKy350bivMvDTImIECAcEdaCSn7X+ia7Br8l5i8karOQ7EPjfMSpNUXxD0m9G7vKyero5C93dALmNw==
X-Received: by 2002:a05:6214:5015:b0:5ad:9d3f:b05e with SMTP id jo21-20020a056214501500b005ad9d3fb05emr50967842qvb.47.1680279813836;
        Fri, 31 Mar 2023 09:23:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id k5-20020a0cebc5000000b005dd8b9345d3sm684243qvq.107.2023.03.31.09.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 09:23:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1piHXI-005jSW-OB;
        Fri, 31 Mar 2023 13:23:32 -0300
Date:   Fri, 31 Mar 2023 13:23:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA: don't ignore client->add() failures
Message-ID: <ZCcJBPbOlmx0he9Y@ziepe.ca>
References: <ZCLOYznKQQKfoqzI@ziepe.ca>
 <a9960371-ef94-de6e-466f-0922a5e3acf3@I-love.SAKURA.ne.jp>
 <ZCLQ0XVSKVHV1MB2@ziepe.ca>
 <ec025592-3390-cf4f-ed03-c3c6c43d9310@I-love.SAKURA.ne.jp>
 <ZCMTZWdY7D7mxJuE@ziepe.ca>
 <d2dfb901-50b1-8e34-8217-d29e63f421c7@I-love.SAKURA.ne.jp>
 <ZCRc5S9QGZqcZhNg@ziepe.ca>
 <9186f5f5-2f88-1247-2d24-61d090a1da83@I-love.SAKURA.ne.jp>
 <ZCYdo8pcS947JOgI@ziepe.ca>
 <747eaa78-5773-c2fd-5a8f-97998a0c9883@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <747eaa78-5773-c2fd-5a8f-97998a0c9883@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Apr 01, 2023 at 01:19:47AM +0900, Tetsuo Handa wrote:
> On 2023/03/31 8:39, Jason Gunthorpe wrote:
> > Look at siw_netdev_event:
> > 
> > 	case NETDEV_UNREGISTER:
> > 		ib_unregister_device_queued(&sdev->base_dev);
> > 		break;
> 
> I see. We can observe that
> 
>   net vlan0: siw: event 6
> 
> is emitted for every second, but unfortunately ib_unregister_device_queued() is
> never called because dev_net(netdev) != &init_net is true. Changing like below
> avoids this problem.
> 
> I guess that either dev_net(netdev) is not appropriately initialized or
> dev_net(netdev) != &init_net is too restrictive to call ib_unregister_device_queued().
> Where is dev_net(netdev) initialized?

Bernard? What is this net ns check for? It seems surprising this would
be here

Jason
