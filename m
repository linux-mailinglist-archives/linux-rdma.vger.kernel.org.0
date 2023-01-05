Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E7565E545
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jan 2023 06:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjAEFyE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Jan 2023 00:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjAEFyD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Jan 2023 00:54:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AB83D9EC
        for <linux-rdma@vger.kernel.org>; Wed,  4 Jan 2023 21:54:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7FABB80D75
        for <linux-rdma@vger.kernel.org>; Thu,  5 Jan 2023 05:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B352FC433EF;
        Thu,  5 Jan 2023 05:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672898039;
        bh=4twFJwUWAQgzhnLdD4o0pQ5pV0/ORbLdUYnbSw3u+XE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=el1xxFIUIvidDCyyXxlB7dQNm/ymLjBDd5n8162HAWvAJShV2TzU3IqiJ+2Wo/Hdi
         +LXYaU9xF7KuYYEHv1T9zzA2QxEmlet9yaBdWMUL+QW8lCK+FeOH1QtXVWsgbJQEP3
         Ox9rPnD4Bdl+NFPGcF+3vTgseKCUgZRHwiMO2U+NX7jWZQdaJvTtLCHocOcHhTn+80
         Z9C9Whm/RdUgQul1hUDRrjtm/Z/ABXeqxkkt/zrc06kjW1pQq+TyOjyxywuOYDDcWR
         M250n9kmv2r2pPQTW7ZHfCj+QlRLI6GXLzYzinFzjdg52XXcv+xqdVgrUSfkuVQ12Z
         0xfHgzCtigl1A==
Date:   Thu, 5 Jan 2023 07:53:54 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Mark Haywood <mark.haywood@oracle.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: buildlib/pandoc-prebuilt
Message-ID: <Y7Zl8k7F1gDNKE9q@unreal>
References: <4c29b8d8-c4c8-a7ae-e1f9-ddce3b55d961@oracle.com>
 <Y7TF8EK/PXiwKRwU@ziepe.ca>
 <612e156e-d8c7-ee17-430d-9d6d85427a3f@oracle.com>
 <Y7W3dASpXM7/br4i@ziepe.ca>
 <Y7XIrX1E78KyfWud@unreal>
 <3c924ffa-5f6c-4a88-85f3-7995e399fe86@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c924ffa-5f6c-4a88-85f3-7995e399fe86@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 04, 2023 at 02:18:42PM -0500, Mark Haywood wrote:
> 
> 
> On 1/4/23 1:42 PM, Leon Romanovsky wrote:
> > On Wed, Jan 04, 2023 at 01:29:24PM -0400, Jason Gunthorpe wrote:
> > > On Wed, Jan 04, 2023 at 11:05:53AM -0500, Mark Haywood wrote:
> > > > 
> > > > On 1/3/23 7:18 PM, Jason Gunthorpe wrote:
> > > > > On Tue, Jan 03, 2023 at 06:04:21PM -0500, Mark Haywood wrote:
> > > > > > I just extracted https://github.com/linux-rdma/rdma-core/releases/download/v44.0/rdma-core-44.0.tar.gz
> > > > > > and noticed that buildlib/pandoc-prebuilt does not exist in v44.0. Is that
> > > > > > intentional?
> > > > > ?
> > > > > 
> > > > > It looks OK:
> > > > > 
> > > > > $ wget https://github.com/linux-rdma/rdma-core/releases/download/v44.0/rdma-core-44.0.tar.gz
> > > > > $ tar -tzf rdma-core-44.0.tar.gz  | grep -i /pandoc-prebuilt/
> > > > > rdma-core-44.0/buildlib/pandoc-prebuilt/
> > > > > rdma-core-44.0/buildlib/pandoc-prebuilt/caaca7667f40fff2095c23c0f40c925f1ff3edea
> > > > > rdma-core-44.0/buildlib/pandoc-prebuilt/e2cfc53feeefa2927ad8741ae5964165b27d6aee
> > > > > rdma-core-44.0/buildlib/pandoc-prebuilt/971674ea9c99ebc02210ea2412f59a09a2432784
> > > > > rdma-core-44.0/buildlib/pandoc-prebuilt/241312b7f23c00b7c2e6311643a22e00e6eedaac
> > > > > [..]
> > > > I can't explain it. The one I pulled yesterday doesn't have them:
> > > > 
> > > > $ tar -tzf rdma-core-44.0.tar.gz.orig  | grep -i /pandoc-prebuilt
> > > > rdma-core-44.0/buildlib/pandoc-prebuilt.py
> > > > 
> > > > The one today does:
> > > > 
> > > > $ tar -tzf rdma-core-44.0.tar.gz  | grep -i /pandoc-prebuilt | less
> > > > rdma-core-44.0/buildlib/pandoc-prebuilt.py
> > > > rdma-core-44.0/buildlib/pandoc-prebuilt/
> > > > rdma-core-44.0/buildlib/pandoc-prebuilt/caaca7667f40fff2095c23c0f40c925f1ff3edea
> > > > rdma-core-44.0/buildlib/pandoc-prebuilt/e2cfc53feeefa2927ad8741ae5964165b27d6aee
> > > > [..]
> > > > 
> > > > I am sure it was user error on may part, though I don't see how. Regardless,
> > > > it's fine now, thanks.
> > > There is a second link:
> > > 
> > > https://github.com/linux-rdma/rdma-core/archive/refs/tags/v44.0.tar.gz
> > > 
> > > That does not include the pandoc, perhaps you downloaded it by
> > > mistake?
> > > 
> > > I don't think the releae tar file changed at least, it is generated by
> > > a script
> > Right, I didn't change and/or force push anything after initial release.
> 
> 
> No problem. As I said, I'm sure it was user error on may part. I think Jason
> is probably right and I just downloaded from the v44.0.tar.gz link.
> 
> I just noticed that clicking on the v44.0 tar.gz link from
> https://github.com/linux-rdma/rdma-core/tags downloads rdma-core-44.0.tar.gz
> on my system and it looks like it is different than https://github.com/linux-rdma/rdma-core/releases/download/v44.0/rdma-core-44.0.tar.gz.

I tried it now and got same file which includes pandoc.

Thanks
