Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CBC7C9F91
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Oct 2023 08:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjJPGcC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Oct 2023 02:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjJPGb5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Oct 2023 02:31:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3423EF7;
        Sun, 15 Oct 2023 23:31:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17F5C433C8;
        Mon, 16 Oct 2023 06:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697437913;
        bh=20RcKOCRsPjkWUxtWVxoneCILhiaUiobXL++bhSC4Cg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rwlnOkgC6zccBetdIF/4nLVwLqjuoMzF5HWii0KFLPnswduyOzUkRYmtvzGUKe6H/
         x71JAKAzBWDfT2YbB6vDhSivu/5WI9dcUj8YSbMWMFChNyCO+nYUAWtd4Z5wwKjzsK
         Czqi2PNjt6lzTOoyMwY8OzRwL3CnEGjua5Aqa/EcpbXlU1WyHH/8KikKyysrqW4NcF
         Waiizhgi2T2ftzXY7vXc8rKZ1RjUcu4YQ8qL8+PKho+32ohOwNEyNMAGM8q3qeu6HG
         Ail+JDmTZh7Uz+Jz/xlXQe7WtQ8reLHFKBG1VMT55zGExDAk3X5NsNf/Fej2sC/T2b
         8h7eP08B+MGFA==
Date:   Mon, 16 Oct 2023 09:31:46 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     David Ahern <dsahern@gmail.com>
Cc:     Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca,
        stephen@networkplumber.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 iproute2-next 2/2] rdma: Add support to dump SRQ
 resource in raw format
Message-ID: <20231016063146.GA4980@unreal>
References: <20231010075526.3860869-1-huangjunxian6@hisilicon.com>
 <20231010075526.3860869-3-huangjunxian6@hisilicon.com>
 <e12077e2-ac6e-ae76-bc11-7795034df6c0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e12077e2-ac6e-ae76-bc11-7795034df6c0@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 15, 2023 at 09:54:14PM -0600, David Ahern wrote:
> On 10/10/23 1:55 AM, Junxian Huang wrote:
> > @@ -162,6 +162,20 @@ out:
> >  	return -EINVAL;
> >  }
> >  
> > +static int res_srq_line_raw(struct rd *rd, const char *name, int idx,
> > +			    struct nlattr **nla_line)
> > +{
> > +	if (!nla_line[RDMA_NLDEV_ATTR_RES_RAW])
> > +		return MNL_CB_ERROR;
> > +
> > +	open_json_object(NULL);
> 
> open_json_object with no corresponding close.
> 
> > +	print_dev(rd, idx, name);
> > +	print_raw_data(rd, nla_line);
> > +	newline(rd);

It is here ^^^^.

  773 void newline(struct rd *rd)
  774 {
  775         close_json_object();
  776         print_color_string(PRINT_FP, COLOR_NONE, NULL, "\n", NULL);
  777 }
  778


> > +
> > +	return MNL_CB_OK;
> > +}
> > +
> >  static int res_srq_line(struct rd *rd, const char *name, int idx,
> >  			struct nlattr **nla_line)
> >  {
> 
> 
