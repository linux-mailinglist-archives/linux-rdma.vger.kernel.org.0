Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB1E77EC22
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Aug 2023 23:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346628AbjHPVpX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Aug 2023 17:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346658AbjHPVpT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Aug 2023 17:45:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B6F1FD0;
        Wed, 16 Aug 2023 14:45:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1FC866F4E;
        Wed, 16 Aug 2023 21:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EEFC433C7;
        Wed, 16 Aug 2023 21:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692222317;
        bh=FjJQ3p3L3eCOYP4PSkk8u0kx6dsnOGxRl/CDOO3tYyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hSH5hvzYYGtyaoIj4t79y+qQhdlp1pZqtXj+OR8/Gw7LPDoPONk4h7IidEVbJvkK4
         aQZ1UOViIbHH5bccc8h1e0EuAm/u+mWcdrRghM0rqZvwBJVnM8Zeq7kIcKCLYvvxVZ
         y1+1ZKwmJThchORtbv8kUXHgRZ2oQpu7oGOKR/xv58j9BkVFcmwOjkLXuxssmgM8zo
         3RvDOabvQ/dUZe86voiH1qTDaKqzi0oCO+Er+ulAnC0ygsIJxs+eCzk7H6ppxkPDjS
         pVqiQ8JjXFw7LEr7CseKTDBQxU4WC2LjjvFrQVXcR9fN4DW3k1C/Hfmg+Dk6PUi5l9
         f03KQHJB6YXKg==
Date:   Wed, 16 Aug 2023 14:45:15 -0700
From:   Saeed Mahameed <saeed@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-pci@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Moshe Shemesh <moshe@mellanox.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net/mlx5: Convert PCI error values to generic errnos
Message-ID: <ZN1Da7oOOKQ/FnxI@x130>
References: <20230814132721.26608-1-ilpo.jarvinen@linux.intel.com>
 <20230814223232.GA195681@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230814223232.GA195681@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 14 Aug 17:32, Bjorn Helgaas wrote:
>On Mon, Aug 14, 2023 at 04:27:20PM +0300, Ilpo Järvinen wrote:
>> mlx5_pci_link_toggle() returns mix PCI specific error codes and generic
>> errnos.
>>
>> Convert the PCI specific error values to generic errno using
>> pcibios_err_to_errno() before returning them.
>>
>> Fixes: eabe8e5e88f5 ("net/mlx5: Handle sync reset now event")
>> Fixes: 212b4d7251c1 ("net/mlx5: Wait for firmware to enable CRS before pci_restore_state")
>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>
>> ---
>>
>> Maintainers beware, this will conflict with read+write -> set/clear_word
>> fixes in pci.git/pcie-rmw. As such, it might be the easiest for Bjorn to
>> take it instead of net people.
>
>I provisionally rebased and applied it on pci/pcie-rmw.  Take a look
>and make sure I didn't botch it -- I also found a case in
>mlx5_check_dev_ids() that looks like it needs the same conversion.
>
>The commit as applied is below.
>
>If networking folks would prefer to take this, let me know and I can
>drop it.
>

I Just took this patch into my mlx5 submission queue and sent it to netdev
tree, please drop it from your tree.

Thanks for the patch,
Saeed.

