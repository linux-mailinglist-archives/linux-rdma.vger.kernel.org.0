Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77C11151CAB
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 15:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgBDO5B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 09:57:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:46374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbgBDO5A (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Feb 2020 09:57:00 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B72920674;
        Tue,  4 Feb 2020 14:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580828220;
        bh=KGDfwPI/gDGhMR+2XqXi5Iy/L567pXfnfHETU5IZIOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QYbf5iwyng7/Q0zSNKYRLjg5bqw8P49JU6l5HdmugWnQjOcQygBSdLCm77JmXlB9Z
         DEWMy2UIGNXUpUJgiEkfY1owavYPl6SMR6752GQNq90RGQK3QXgacUyZF4nzOky8Mz
         jbMlw9rsGijRzVaYXfLXjz0C/rv8G9kF/X+HKxlw=
Date:   Tue, 4 Feb 2020 16:56:57 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Goldman, Adam" <adam.goldman@intel.com>
Cc:     linux-rdma@vger.kernel.org, mike.marciniszyn@intel.com,
        dennis.dalessandro@intel.com
Subject: Re: [PATCH] kernel-boot: Do not perform device rename on OPA devices
Message-ID: <20200204145657.GY414821@unreal>
References: <1580824520-38122-1-git-send-email-adam.goldman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580824520-38122-1-git-send-email-adam.goldman@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 04, 2020 at 08:55:20AM -0500, Goldman, Adam wrote:
> From: "Goldman, Adam" <adam.goldman@intel.com>
>
> PSM2 will not run with recent rdma-core releases. Several tools and
> libraries like PSM2, require the hfi1 name to be present.
>
> Recent rdma-core releases added a new feature to rename kernel devices,
> but the default configuration will not work with hfi1 fabrics.
>
> Related opa-psm2 github issue:
>   https://github.com/intel/opa-psm2/issues/43

Why don't you fix opa-psm2 and add required rdma-core version
checks inside packaging spec files, like we have inside
redhat/rdma-core.spec?

Thanks
