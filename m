Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EF5602E22
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 16:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJROTU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 10:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJROTT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 10:19:19 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA88C5138
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 07:19:17 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id i9so9383794qvu.1
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 07:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tyKg35I/fC/6qjBHQJJCU8zltrFBVuRFgzo1HKpJ8cE=;
        b=AKhM1p7NWOfhcHdT+AMQuqMBCu0RQjzxCh3rJMIv+dDRM4YzQlpwtY76R5kNiFpQOO
         5PpbnxTm0jtxCNrTZSa7htHyYIfW/+kDp7SwUwimAAhl8HFY26mfCkv66lF6YMnEuo9U
         7CM3KS5QsNijsU+XhE+8CJNhldDcJYR45OozRxeux0Zn0BLKRS7Qiw93QBhbpl2Aly6C
         KqvyixTOVS0ovPDVOlN8YbigfBl/zKma/3cOmcCgkpT3AkrxseYMhoBxytFSb5Bwn/QV
         GP+5i1ZOYvJfI1Vzu2tQ6vuIxkdVy5epsT/L32c0wsRZ9Ff+Goj3Wl2rfKkEj5hmfm1m
         cSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyKg35I/fC/6qjBHQJJCU8zltrFBVuRFgzo1HKpJ8cE=;
        b=bn4JFqAZyhUb2xpDD6/DtsNZaCUHgaQcOXtU0fFmOSJrd7LKtYWB4A6bsGiQcNVXo1
         ix6iC9gAe9cvFm7oJJ04DNH1iZxdEwKmhw+dl3IgQd/tIgYXlrgFv1wHj9/GI+qx8JPv
         jCM5DJFiNfhO5bUthpJigCRKhucwJ6mL/kD0LTKwSyxhiuMLMSZ/1On9PyUVWki9vRdF
         7ssFD791Wit9UQEkZjh1sJWuZ1EShen6JqRjmAXxxqkfbkv404ACSd+c1IaHfT+8fcH+
         SkZ6SIqxaXG7YwC2iwIzgKABhMGnrSqQUuH77Nse6oJigDgRyc8TA3wYqXIpAABITteL
         9iUA==
X-Gm-Message-State: ACrzQf0XX1mrZeAITmfveErSzVCCC905b79guBBsbZ2EcJlC0J+Beyzz
        hw+UDjt2v6sFlszsjqcYf9wdpw==
X-Google-Smtp-Source: AMsMyM4W1JAowbJ/E87kQZsfil8x5X5PNKEgtJw8PTtkY7VEONGydESQTnM4InrKhE9Px9GHoObvhQ==
X-Received: by 2002:a05:6214:2689:b0:4b1:892e:9bd0 with SMTP id gm9-20020a056214268900b004b1892e9bd0mr2591641qvb.25.1666102756661;
        Tue, 18 Oct 2022 07:19:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id cb23-20020a05622a1f9700b0039cc22a2c49sm1995123qtb.47.2022.10.18.07.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 07:19:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oknR4-008F1C-KX;
        Tue, 18 Oct 2022 11:19:14 -0300
Date:   Tue, 18 Oct 2022 11:19:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev
Subject: Re: [PATCH 1/1] RDMA/mlx5: Make mlx5 device work with
 ib_device_get_by_netdev
Message-ID: <Y0614lU6j0Bp/g8A@ziepe.ca>
References: <20221016061925.1831180-1-yanjun.zhu@intel.com>
 <Y05iy+/0BUvbwp5z@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y05iy+/0BUvbwp5z@unreal>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 18, 2022 at 11:24:43AM +0300, Leon Romanovsky wrote:
> On Sun, Oct 16, 2022 at 02:19:25AM -0400, Zhu Yanjun wrote:
> > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > 
> > Before mlx5 ib device is registered, the function ib_device_set_netdev
> > is not called to map the mlx5 ib device with the related net device.
> > 
> > As such, when the function ib_device_get_by_netdev is called to get ib
> > device, NULL is returned.
> > 
> > Other ib devices, such as irdma, rxe and so on, the function
> > ib_device_get_by_netdev can get ib device from the related net device.
> 
> Ohh, you opened Pandora box, everything around it looks half-backed.
> 
> mlx4 and mlx5 don't call to ib_device_set_netdev(), because they have
> .get_netdev() callback. This callback is not an easy task to eliminate
> and many internal attempts failed to eliminate them.
> 
> This caused to very questionable ksmbd_rdma_capable_netdev()
> implementation where ksmbd first checked internal ib_dev callback
> and tried to use ib_device_get_by_netdev(). And to smc_ib, which
> didn't even bother to use ib_device_get_by_netdev().

Oh really? Those APIs were only for driver use, not ULP :(

Jason
