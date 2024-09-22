Return-Path: <linux-rdma+bounces-5037-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B436D97E1E7
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Sep 2024 15:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D571C20B95
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Sep 2024 13:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDB91FBA;
	Sun, 22 Sep 2024 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjxq3suH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD3A23;
	Sun, 22 Sep 2024 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727013181; cv=none; b=NiGPZcHTYQtlDjReXX4dRsvMJqezXs58VvpM5thU/doELj5r75IlM0s8eWA1XrsgCy/H0qfWdalKRSR/qlDkR3al3pqcKLH5HaAkdwqMndH19bBcSSZB1PlSh7N1su1dn8A6I2NzOcu+Vy63HkL6v2gkUOBYfnmE0JL6rEaAEMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727013181; c=relaxed/simple;
	bh=vFpfm6cUZrok1HULVCGdKB193zCuxSr1bD0uzFnfb5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2LS/6q6DzJI3xWZtFg0WINsmTBIXM/tWxyeHUjlDYXA7MwVgRvqHVZ8QeqrudB/iKl3YAf7TWbYhXw27PJxMVlDsk2ddVX8ln0IgMSKY9RTDgtMAwEGKN/kz1XGzHAp0AK62Kkuvtz4BNIlVCgTdpw7tZC38u82Lw76CbYoiBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjxq3suH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AC4C4CEC3;
	Sun, 22 Sep 2024 13:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727013181;
	bh=vFpfm6cUZrok1HULVCGdKB193zCuxSr1bD0uzFnfb5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cjxq3suHjMQZIZf/jxNbo9NjCl75/fyoDGveKXTkjcG8GguYInUpvozI8PcXDAsKq
	 Aor9TBUebqbrf4yjRdL6TUOuIsYAzA0kVpAsovqpHI8Bfwz+nbvapDyqcVj/FWKhSJ
	 TWAwxghh07HkvuPN4zppi7Tpw7In3lcCWtFDzP5XYuqLb+nfxeu+Fbh2BASRiXbPuR
	 Vxh9Pch45jglChVDuoc9D25iY333SGvvaBywyfBHJ4GspVUdvf+gsbjNehkt04AGe2
	 uXQ61G5urfGjIHG130FJL5LlVF2D80zGbE1Rf4iAIi08sE9hYufmFFHdgrwZLEb7Jm
	 wKH5hZkMePBMg==
Date: Sun, 22 Sep 2024 16:52:43 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] RDMA/bnxt_re: Remove the unused variable en_dev
Message-ID: <20240922135243.GB11337@unreal>
References: <20240918021632.36091-1-jiapeng.chong@linux.alibaba.com>
 <CA+sbYW0zy=kD1JyYbG--keYAv146+SXvuxdQh6dHnvbVCHd9kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sbYW0zy=kD1JyYbG--keYAv146+SXvuxdQh6dHnvbVCHd9kw@mail.gmail.com>

On Thu, Sep 19, 2024 at 02:16:11PM +0530, Selvin Xavier wrote:
> On Wed, Sep 18, 2024 at 7:46 AM Jiapeng Chong
> <jiapeng.chong@linux.alibaba.com> wrote:
> >
> > Variable en_dev is not effectively used, so delete it.
> >
> > drivers/infiniband/hw/bnxt_re/main.c:1980:22: warning: variable ‘en_dev’ set but not used.
> 
> Not sure if you are applying v1 of a previous patch series. A similar
> issue was reported by kernel test robot and i fixed in v2. I dont see
> this code in the latest driver code.

Similar but not the same, I applied your v2 series, but Jiapeng's patch
is valid:

  1977 static void bnxt_re_remove(struct auxiliary_device *adev)
  1978 {
  1979         struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(adev);
  1980         struct bnxt_en_dev *en_dev;
  1981         struct bnxt_re_dev *rdev;
  1982
  1983         mutex_lock(&bnxt_re_mutex);
  1984         if (!en_info) {
  1985                 mutex_unlock(&bnxt_re_mutex);
  1986                 return;
  1987         }
  1988         en_dev = en_info->en_dev;
  1989         rdev = en_info->rdev;
  1990
  1991         if (rdev)
  1992                 bnxt_re_remove_device(rdev, BNXT_RE_COMPLETE_REMOVE, adev);
  1993         kfree(en_info);
  1994         mutex_unlock(&bnxt_re_mutex);
  1995 }


Thanks

